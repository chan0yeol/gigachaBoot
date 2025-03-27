document.addEventListener('DOMContentLoaded', function() {
	// 요소들
	const checkInButton = document.querySelector('.btn-check-in');
	const checkOutButton = document.querySelector('.btn-check-out');
	const noticeText = document.querySelector('.notice');

	// 출근 상태를 추적하는 변수들
	let isCheckedIn = false;
	let checkInTime = null;
	let workTimer = null;
	let totalWorkedSeconds = 0;
	let syncInterval = null;

	// 시간을 HH:MM:SS 형식으로 포맷하는 함수
	function formatTime(seconds) {
		const hours = Math.floor(seconds / 3600);
		const minutes = Math.floor((seconds % 3600) / 60);
		const secs = Math.floor(seconds % 60);

		return [
			hours.toString().padStart(2, '0'),
			minutes.toString().padStart(2, '0'),
			secs.toString().padStart(2, '0')
		].join(':');
	}

	// 날짜 객체를 HH:MM:SS 형식으로 변환
	function formatTimeString(dateObj) {
		const hours = dateObj.getHours().toString().padStart(2, '0');
		const minutes = dateObj.getMinutes().toString().padStart(2, '0');
		const seconds = dateObj.getSeconds().toString().padStart(2, '0');

		return `${hours}:${minutes}:${seconds}`;
	}

	// 내비게이션 바에 현재 날짜와 시간 업데이트
	function updateCurrentDateTime() {
		const navTimeElement = document.querySelector('.time-display');
		const now = new Date();

		const hours = now.getHours();
		const minutes = now.getMinutes();
		const seconds = now.getSeconds();
		const ampm = hours >= 12 ? 'PM' : 'AM';
		const hour12 = hours % 12 || 12;

		const month = now.getMonth() + 1;
		const date = now.getDate();
		const day = ['일', '월', '화', '수', '목', '금', '토'][now.getDay()];

		const timeString = `${month}/${date}(${day}) ${ampm} ${hour12}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
		navTimeElement.innerHTML = `<i class="ri-bear-smile-line"></i> ${timeString}`;

		setTimeout(updateCurrentDateTime, 1000);
	}

	// 근무 타이머 시작
	function startWorkTimer() {
		// 기존 타이머가 있으면 중지
		if (workTimer) {
			clearInterval(workTimer);
		}

		workTimer = setInterval(() => {
			totalWorkedSeconds++;
			//			timeDisplay.textContent = formatTime(totalWorkedSeconds);
		}, 1000);
	}

	// 주기적으로 DB에 근무 시간 동기화
	function startPeriodicSync() {
		// 기존 동기화 인터벌이 있으면 중지
		if (syncInterval) {
			clearInterval(syncInterval);
		}

		syncInterval = setInterval(() => {
			if (isCheckedIn) {
				// 진행 중인 근무 시간 업데이트
				const empno = document.getElementById('empno').value;
				const requestBody = {
					empno: empno,
					current_worked_seconds: totalWorkedSeconds
				};

				fetch('./updateWorkingTime.do', {
					method: 'POST',
					headers: { 'Content-Type': 'application/json' },
					body: JSON.stringify(requestBody)
				})
					.then(response => {
						if (!response.ok) {
							console.log('근무 시간 동기화 실패');
						}
					})
					.catch(error => console.error('근무 시간 동기화 오류:', error));
			}
		}, 300000); // 5분(300,000ms)마다
	}

	// 출근 함수
	function checkIn() {
		console.log("출근 상태 확인:", isCheckedIn);
		if (isCheckedIn) {
			console.log("이미 출근 상태입니다.");
			return;
		}

		isCheckedIn = true;
		//		console.log("출근 함수>>>", isCheckedIn);
		checkInTime = new Date();


		// UI 업데이트
		checkInButton.style.backgroundColor = '#cccccc';
		checkInButton.disabled = true;
		checkOutButton.style.backgroundColor = '#ff6b6b';
		checkOutButton.style.color = 'white';
		checkOutButton.disabled = false;

		noticeText.textContent = '출근 등록이 완료되었습니다.';

		// 타이머 시작 - 이전에 누적된 시간부터 계속
		startWorkTimer();

		// 주기적 동기화 시작
		startPeriodicSync();

		// 로컬 스토리지에 출근 상태 저장 (임시 백업용)
		localStorage.setItem('attendanceState', JSON.stringify({
			isCheckedIn: true,
			checkInTime: checkInTime.toISOString(),
			totalWorkedSeconds: totalWorkedSeconds
		}));

		// 서버에 출근 기록 저장
		updateAttendanceTable('check-in', checkInTime, totalWorkedSeconds);
		saveAttendanceRecord('check-in', checkInTime);
	}

	// 퇴근 함수
	function checkOut() {
		if (!isCheckedIn) return;

		isCheckedIn = false;
		const checkOutTime = new Date();

		// 타이머를 멈춤
		clearInterval(workTimer);
		workTimer = null;

		// 동기화 인터벌 중지
		clearInterval(syncInterval);
		syncInterval = null;

		// 화면에 총 누적 근무 시간 표시
		//		timeDisplay.textContent = formatTime(totalWorkedSeconds);

		// UI 업데이트
		checkInButton.style.backgroundColor = '#26c6da';
		checkInButton.disabled = false;
		checkOutButton.style.backgroundColor = 'white';
		checkOutButton.style.color = '#333';
		checkOutButton.disabled = true;

		noticeText.textContent = '퇴근 등록이 완료되었습니다. 오늘 하루도 수고하셨습니다.';

		// 로컬 스토리지에 출근 상태 및 누적 시간 저장 (임시 백업용)
		localStorage.setItem('attendanceState', JSON.stringify({
			isCheckedIn: false,
			totalWorkedSeconds: totalWorkedSeconds
		}));

		//		console.log('누적시간 : ', totalWorkedSeconds);

		// 최종 근무 기록 저장 (총 누적 시간 기록)
		updateAttendanceTable('check-out', checkOutTime, totalWorkedSeconds);
		saveAttendanceRecord('check-out', checkOutTime, totalWorkedSeconds);
	}

	// 근태 테이블 업데이트 함수
	function updateAttendanceTable(type, time, total) {
		const now = new Date(time);
		const year = now.getFullYear();
		const month = String(now.getMonth() + 1).padStart(2, '0');
		const day = String(now.getDate()).padStart(2, '0');

		// 날짜 형식 YYYYMMDD
		const formattedDate = `${year}${month}${day}`;

		// 시간 형식 HH:MM:SS
		const formattedTime = `${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}:${String(now.getSeconds()).padStart(2, '0')}`;

		// 출근 또는 퇴근에 따른 셀 인덱스 설정
		const cellIndex = type === 'check-in' ? 0 : 1; // 0은 출근, 1은 퇴근 셀

		// 해당 셀 ID 생성
		const cellId = `${formattedDate}-${cellIndex}`;

		//		console.log('업데이트 중인 셀:', cellId, '시간:', formattedTime);

		// 셀 찾기
		const cell = document.getElementById(cellId);

		if (cell) {
			if (type == 'check-in') {
				var workintextContent = cell.textContent;
				// 셀이 비어있을 때만 출근 시간 업데이트
				if (workintextContent == "") {
					cell.textContent = formattedTime;
					document.getElementById('workInTime').textContent = formattedTime;
				}
			} else if (type == 'check-out') {
				// 퇴근 시간은 항상 업데이트
				cell.textContent = formattedTime;

				// 총 근무 시간을 HH:MM:SS 형식으로 변환
				const totalFormattedTime = formatTime(total);

				// 총 근무 시간 표시 (4번째 셀에 표시)
				const totalWorkTimeCell = document.getElementById(`${formattedDate}-4`);
				//				console.log('총 근무 시간 셀:', `${formattedDate}-4`);

				if (totalWorkTimeCell) {
					totalWorkTimeCell.textContent = totalFormattedTime;
				}
				document.getElementById('workOutTime').textContent = formattedTime;
			}
		}
	}

	//누적 근무기록 저장
	function saveMonthWorkTotal(total) {

		document.getElementById("");

	}

	// 출근 기록 저장
	function saveAttendanceRecord(type, time, duration = null) {
		console.log('출근 기록 저장:', {
			type,
			time: time.toISOString(),
			duration
		});

		const empno = document.getElementById('empno').value;

		let requestBody = {
			type: type,
			empno: empno,
			workin_time: time.toISOString()
		};

		// 퇴근인 경우 총 근무 시간도 함께 저장
		if (type === 'check-out' && duration !== null) {
			requestBody.workout_time = time.toISOString();
			requestBody.total_worked_seconds = duration;
		}

		console.log("requestBody:", requestBody);

		fetch('./workIn.do', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(requestBody)
		})
			.then(response => {
				// 응답이 JSON인지 확인하고, 그렇지 않으면 텍스트로 처리
				const contentType = response.headers.get('content-type');
				if (contentType && contentType.includes('application/json')) {
					return response.json();
				} else {
					return response.text().then(text => {
						console.log('서버 응답 (텍스트):', text);
						return { success: response.ok, message: '서버 응답이 JSON이 아닙니다.' };
					});
				}
			})
			.then(data => console.log('성공:', data))
			.catch(error => console.error('오류:', error));
	}

	// DB에서 오늘의 출근 정보 로드
	// 오늘 출근 정보 로드 함수에서 출근 기록이 없을 경우 초기화
	function loadTodayAttendanceFromDB(selectedYear, selectedMonth) {
		const empno = document.getElementById('empno').value;
		const today = new Date();
		let formattedDate;

		if (selectedYear === undefined || selectedMonth === undefined) {
			formattedDate = `${today.getFullYear()}${String(today.getMonth() + 1).padStart(2, '0')}${String(today.getDate()).padStart(2, '0')}`;
		} else {
			formattedDate = `${selectedYear}${String(selectedMonth + 1).padStart(2, '0')}${String(today.getDate()).padStart(2, '0')}`;
		}

		let data = { empno: empno, attno: formattedDate };

		fetch('./getAttendance.do', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(data)
		})
			.then(response => response.json())
			.then(handleAttendanceResponse)  // 서버 응답 처리 함수 호출
			.catch(handleAttendanceError);    // 오류 처리 함수 호출
	}

	function handleAttendanceResponse(data) {
		console.log("📢 서버에서 받아온 데이터:", data);

		const attendancelist = data.map(res => ({
			attno: res.ATTNO,
			workin_time: res.WORKIN_TIME ? new Date(res.WORKIN_TIME - (new Date().getTimezoneOffset() * 60000)).toISOString().slice(0, 19).replace("T", " ") : null,
			workout_time: res.WORKOUT_TIME ? new Date(res.WORKOUT_TIME - (new Date().getTimezoneOffset() * 60000)).toISOString().slice(0, 19).replace("T", " ") : null,
			work_status: res.WORK_STATUS
		}));

		console.log("📌 변환된 이벤트 데이터:", attendancelist);

		// 모든 출근 데이터를 테이블에 표시
		displayAllAttendanceData(attendancelist);

		const today = new Date();
		const todayFormatted = `${today.getFullYear()}${String(today.getMonth() + 1).padStart(2, '0')}${String(today.getDate()).padStart(2, '0')}`;
		const todayAttendance = attendancelist.find(item =>
			item.attno === todayFormatted.substring(2) || // 연도 두 자리만 있는 경우
			item.attno === todayFormatted // 전체 연도가 있는 경우
		);

		//		console.log("todayFormatted:", todayFormatted);
		//		console.log("todayAttendance:", todayAttendance);

		if (!todayAttendance || !todayAttendance.workin_time) {
			console.log("📌 오늘 출근 기록이 없음");

			// 출근 기록이 없을 때 UI 초기화 추가
			checkInButton.style.backgroundColor = '#26c6da';
			checkInButton.disabled = false;
			checkOutButton.style.backgroundColor = 'white';
			checkOutButton.style.color = '#333';
			checkOutButton.disabled = true;
			noticeText.textContent = '출근 등록을 해주세요.';

			isCheckedIn = false;
			//			console.log("📌 초기화 후 >>> isCheckedIn", isCheckedIn);
		} else {
			// 출근 기록이 있는 경우 처리
			processAttendanceData(todayAttendance);
			isCheckedIn = todayAttendance.workout_time ? false : true; // 퇴근 시간이 있으면 false, 없으면 true
			console.log("📌 isCheckedIn", isCheckedIn);
		}
	}

	// 출근 기록을 처리하는 함수 (출근 기록이 있는 경우 호출)
	function processAttendanceData(data) {
		if (data.workin_time) {
			const checkInTime = new Date(data.workin_time);
			let totalWorkedSeconds = 0;

			if (data.workout_time) {
				// 퇴근 시간이 있는 경우
				const checkOutTime = new Date(data.workout_time);
				totalWorkedSeconds = data.total_worked_seconds || Math.floor((checkOutTime - checkInTime) / 1000);

				// 출근은 가능하고 퇴근은 불가능하도록 설정
				checkInButton.style.backgroundColor = '#26c6da';
				checkInButton.disabled = false;
				checkOutButton.style.backgroundColor = 'white';
				checkOutButton.style.color = '#333';
				checkOutButton.disabled = true;
				noticeText.textContent = '오늘의 근무가 종료되었습니다.';

				// 출근 및 퇴근 시간 포맷팅
				const inTimeFormatted = formatTimeString(checkInTime);
				const outTimeFormatted = formatTimeString(checkOutTime);
				document.getElementById('workInTime').textContent = inTimeFormatted;
				document.getElementById('workOutTime').textContent = outTimeFormatted;

				// 출근 기록과 퇴근 기록을 테이블에 업데이트
				updateAttendanceTable('check-in', checkInTime, 0);
				updateAttendanceTable('check-out', checkOutTime, totalWorkedSeconds);

				// 근무 시간 타이머 시작
				startWorkTimer();
				// 주기적인 동기화 시작
				startPeriodicSync();
			} else {
				// 퇴근 시간이 없는 경우 (출근만 한 경우)
				const now = new Date();
				totalWorkedSeconds = Math.floor((now - checkInTime) / 1000);

				// 근무 시간 타이머 및 동기화 시작
				startWorkTimer();
				startPeriodicSync();

				// UI 업데이트: 출근 버튼 비활성화, 퇴근 버튼 활성화
				checkInButton.style.backgroundColor = '#cccccc';
				checkInButton.disabled = true;
				checkOutButton.style.backgroundColor = '#ff6b6b';
				checkOutButton.style.color = 'white';
				checkOutButton.disabled = false;
				noticeText.textContent = '출근 중입니다. 퇴근하시려면 퇴근 버튼을 눌러주세요.';

				// 출근 시간 표시
				const inTimeFormatted = formatTimeString(checkInTime);
				document.getElementById('workInTime').textContent = inTimeFormatted;

				// 출근 기록을 테이블에 업데이트
				updateAttendanceTable('check-in', checkInTime, 0);

				// 로컬 스토리지에 출근 정보 저장
				//				console.log("로컬 스토리지에 출근 정보 저장");
				localStorage.setItem('attendanceState', JSON.stringify({
					isCheckedIn: true,
					checkInTime: checkInTime.toISOString(),
					totalWorkedSeconds: totalWorkedSeconds
				}));
			}
		} else {
			// 출근 기록이 없는 경우
			resetIfNoAttendance();
		}
	}

	// 오류 처리 함수
	function handleAttendanceError(error) {
		console.error('출근 정보 로드 오류:', error);
		resetIfNoAttendance(); // 오류 발생 시 초기화
	}

	// 출근 셀 체크 후 초기화 함수
	function resetIfNoAttendance() {
		const today = new Date();
		const formattedDate = `${today.getFullYear()}${String(today.getMonth() + 1).padStart(2, '0')}${String(today.getDate()).padStart(2, '0')}`;
		const workInCell = document.getElementById(`${formattedDate}-0`);
		console.log("출근 기록 없음. 로컬 스토리지 초기화 및 출근 상태 리셋");
		// 출근 셀의 값이 비어있다면 출근 상태 초기화
		if (!workInCell || workInCell.textContent.trim() === "") {
			console.log("출근 기록 없음. 로컬 스토리지 초기화 및 출근 상태 리셋");
			localStorage.removeItem('attendanceState');  // 로컬 스토리지 초기화
			isCheckedIn = false; // 출근 상태 초기화
			document.getElementById('workInTime').textContent = "00:00:00";
			document.getElementById('workOutTime').textContent = "00:00:00";
		} else {
			console.log("출근 기록 없음. 로컬 스토리지 초기화 및 출근 상태 리셋");
			localStorage.removeItem('attendanceState');  // 로컬 스토리지 초기화
			isCheckedIn = false; // 출근 상태 초기화
			document.getElementById('workInTime').textContent = "00:00:00";
			document.getElementById('workOutTime').textContent = "00:00:00";
		}
	}

	// 현재 월의 데이터를 기반으로 출석 테이블 초기화
	function initAttendanceTable() {
		// 실제로는 서버에서 데이터를 불러오는 작업
		// 예시: fetchAttendanceRecords(year, month);
	}

	// 이벤트 리스너 설정
	checkInButton.addEventListener('click', checkIn);
	checkOutButton.addEventListener('click', checkOut);

	// TODAY 버튼 클릭 이벤트 리스너
	const showTodayButton = document.getElementById('showtoday');
	if (showTodayButton) {
		showTodayButton.addEventListener('click', function() {
			const today = new Date();
			const year = today.getFullYear();
			const month = today.getMonth();
			const day = today.getDate();

			//			console.log("📢 선택된 연도:", year);
			//			console.log("📢 선택된 월:", month + 1);

			// ✅ 1. 연도/월 선택 박스 값 변경
			document.getElementById('yearSelect').value = year;
			document.getElementById('monthSelect').value = month + 1; // 1부터 시작

			// ✅ 2. 월 옵션 다시 로드
			const hireYear = hireDate ? hireDate.getFullYear() : year;
			const hireMonth = hireDate ? hireDate.getMonth() : 0;
			//			console.log("✅ hireYear,hireMonth : ", hireYear, hireMonth);

			populateMonths(year === hireYear ? hireMonth : 0);

			// ✅ 3. 테이블 다시 로드
			populateDates();
			loadTodayAttendanceFromDB();

			// ✅ 4. 자동 스크롤 실행
			setTimeout(() => {
				const todayId = `${year}${String(month + 1).padStart(2, '0')}${String(day).padStart(2, '0')}`;
				//				console.log("✅ 3. todayId", todayId);  // "20250314" 형식으로 출력되는지 확인
				const todayRowElement = document.querySelector(`td[id="${todayId}"]`);
				//				console.log("✅ 3. todayRowElement", todayRowElement);

				if (todayRowElement) {
					const todayRow = todayRowElement.parentElement;
					todayRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
				} else {
					console.log("⚠️ 오늘 날짜의 행을 찾지 못함.");
				}
			}, 100); // 500ms 정도로 설정해 테스트
		});
	}

	// 초기화
	updateCurrentDateTime();
	loadTodayAttendanceFromDB(); // DB에서 출근 정보 로드
	initAttendanceTable();
	updateMonthlyWorkHours();
	EmployeeLevae();


	// 선택사항: 출근 중일 때 페이지를 떠날 경우 확인 메시지
	window.addEventListener('beforeunload', function(e) {
		if (isCheckedIn) {
			const message = '출근 상태입니다. 페이지를 나가시겠습니까?';
			e.returnValue = message;
			return message;
		}
	});

	// 입사일
	// 입사일 설정 (예: 2020년 3월 입사)

	var hireDateText = document.getElementById('hiredate').textContent;

	var year = hireDateText.slice(1, 5);
	var month = hireDateText.slice(6, 8);
	var date = hireDateText.slice(9, 12);

	const hireDate = new Date(year, month, date); // 월은 0부터 시작하므로 3월은 2입니다

	// 현재 날짜
	const currentDate = new Date();

	// 년도 셀렉트 박스 채우기
	const yearSelect = document.getElementsByName('yearSelect');
	var selectyear = [];

	// 년도 옵션 생성
	for (let year = hireDate.getFullYear(); year <= currentDate.getFullYear(); year++) {
		const option = document.createElement('option');
		option.value = year;
		option.textContent = year + '년';
		selectyear.push(option);
	}

	// 모든 yearSelect 요소에 옵션을 추가
	for (var i = 0; i < yearSelect.length; i++) {
		for (var j = 0; j < selectyear.length; j++) {
			yearSelect[i].appendChild(selectyear[j].cloneNode(true));
		}

		// 현재 년도 기본 선택
		yearSelect[i].value = currentDate.getFullYear();  // 현재 년도로 선택
	}

	// 월 셀렉트 박스 채우기
	function populateMonths(startMonth = 0) {
		// 기존 옵션 삭제
		monthSelect.innerHTML = ''; // 기존의 테이블 데이터 삭제

		const endMonth = (getCurrentYearValue() == currentDate.getFullYear())
			? currentDate.getMonth()
			: 11;

		for (let month = startMonth; month <= endMonth; month++) {
			const option = document.createElement('option');
			option.value = month + 1; // 월은 1부터 시작
			option.textContent = (month + 1) + '월';

			// 현재 월을 기본 선택
			if (month == currentDate.getMonth() &&
				getCurrentYearValue() == currentDate.getFullYear()) {
				option.selected = true;
			}

			monthSelect.appendChild(option);
		}
	}

	// yearSelect에서 현재 선택된 값을 가져오는 함수
	function getCurrentYearValue() {
		for (var i = 0; i < yearSelect.length; i++) {
			if (yearSelect[i].selectedIndex != -1) {
				return parseInt(yearSelect[i].options[yearSelect[i].selectedIndex].value);
			}
		}
		return currentDate.getFullYear(); // 기본값으로 현재 년도 반환
	}

	// 모든 yearSelect 요소에 change 이벤트 리스너 추가
	for (var i = 0; i < yearSelect.length; i++) {
		yearSelect[i].addEventListener('change', function() {
			const selectedYear = parseInt(this.value);

			if (selectedYear == hireDate.getFullYear()) {
				// 입사 년도면 입사 월부터 시작
				populateMonths(hireDate.getMonth());
			} else {
				// 다른 년도면 1월부터 시작
				populateMonths();
			}

			// 테이블 업데이트
			const selectedMonth = parseInt(monthSelect.value) - 1;
			populateDates(selectedYear, selectedMonth);
		});
	}

	// 초기 월 옵션 설정
	if (getCurrentYearValue() == hireDate.getFullYear()) {
		populateMonths(hireDate.getMonth());
	} else {
		populateMonths();
	}

	// 근무일수 계산하기
	// 경과 시간 계산
	var yearDiff = currentDate.getFullYear() - hireDate.getFullYear();
	var monthDiff = currentDate.getMonth() - hireDate.getMonth();

	// 월 차이가 음수인 경우 년도에서 1을 빼고 월에 12를 더함
	if (monthDiff < 0) {
		yearDiff--;
		monthDiff += 12;
	}

	// 일자 비교 - 현재 일자가 입사 일자보다 작으면 월에서 1을 뺌
	if (currentDate.getDate() < hireDate.getDate()) {
		monthDiff--;
		if (monthDiff < 0) {
			yearDiff--;
			monthDiff += 12;
		}
	}

	// 결과 생성
	var tenureText = yearDiff + "년 " + monthDiff + "개월";

	// 콘솔에도 표시 (디버깅용)
	//	console.log("근무 기간: " + tenureText);
	document.getElementById('hiredate').innerHTML = year + "-" + month + "-" + date;
	document.getElementById('hiredateText').innerHTML = "(" + tenureText + ")";

	// 표 미리 만들어두기
	const tbody = document.getElementById('attendanceTable').querySelector('tbody');

	/// 월에 맞는 일자를 채우는 함수
	function populateDates(year, month) {
		const tbody = document.getElementById('attendanceTable').querySelector('tbody');
		tbody.innerHTML = ''; // 기존의 테이블 데이터 삭제

		const today = new Date();
		const todayYear = today.getFullYear();
		const todayMonth = today.getMonth();
		const todayDate = today.getDate();

		if (year == undefined || month == undefined) {
			year = todayYear;
			month = todayMonth;
		}

		const daysInMonth = new Date(year, month + 1, 0).getDate(); // month + 1로 해당 월의 마지막 날짜를 구함

		// 요일 배열 (일, 월, 화, 수, 목, 금, 토)
		const weekdays = ['일', '월', '화', '수', '목', '금', '토'];

		for (let day = 1; day <= daysInMonth; day++) {
			const row = document.createElement('tr');

			// 일자 셀 생성
			const dateCell = document.createElement('td');
			// 날짜 값을 YYYYMMDD 형식으로 변환
			const formattedDate = `${year}${String(month + 1).padStart(2, '0')}${String(day).padStart(2, '0')}`;

			// 고유한 id를 날짜 형식에 '-5'를 추가하여 설정
			dateCell.id = formattedDate;

			// 날짜와 요일 표시
			const date = new Date(year, month, day);
			const dayOfWeek = date.getDay(); // 0: 일요일, 6: 토요일
			dateCell.textContent = `${month + 1}월 ${day}일 (${weekdays[dayOfWeek]})`; // 예: 3월 1일(화)

			// 오늘 날짜일 경우 색상 추가
			if (year === todayYear && month === todayMonth && day === todayDate) {
				dateCell.style.fontWeight = 'bold';  // 글자 굵게 만들기
				row.classList.add('table-warning', 'text-white'); // 오늘 날짜에 배경색 추가
			}

			// 주말 체크 (토요일=6, 일요일=0)
			if (dayOfWeek === 6) {
				dateCell.style.color = 'blue'; // 토요일은 파란색
			} else if (dayOfWeek === 0) {
				dateCell.style.color = 'red'; // 일요일은 빨간색
			}

			row.appendChild(dateCell);

			// 출근, 퇴근, 연장, 야간, 합계, 상태 셀을 추가 (빈 셀로)
			for (let i = 0; i < 6; i++) {
				const emptyCell = document.createElement('td');
				emptyCell.id = `${formattedDate}-${i}`;
				row.appendChild(emptyCell);
			}

			// 생성된 행을 tbody에 추가
			tbody.appendChild(row);
		}

		// 월에 해당하는 출퇴근 기록 로드
		//		loadMonthlyAttendanceData(year, month + 1);
		fetchLeaveData();
	}


	// 월 셀렉트 박스 변경 시 테이블 업데이트
	monthSelect.addEventListener('change', function() {
		const selectedYear = getCurrentYearValue();
		const selectedMonth = parseInt(this.value);  // 1부터 시작하는 월
		populateDates(selectedYear, selectedMonth - 1);  // 0부터 시작하는 월로 변환
		loadMonthlyAttendanceData(selectedYear, selectedMonth);  // 월 데이터 로드
	});

	// 기본 값으로 현재 월에 맞는 일자 채우기
	const currentYear = new Date().getFullYear();
	const currentMonth = new Date().getMonth();
	populateDates(currentYear, currentMonth);
	loadMonthlyAttendanceData(currentYear, currentMonth + 1);  // 1부터 시작하는 월로 변환

	//클릭한 행 가져오기 
	tbody.addEventListener('click', function(event) {
		// 클릭된 요소가 'tr'인 경우에만 처리
		if (event.target.closest('tr')) {
			const clickedRow = event.target.closest('tr'); // 클릭한 행 (tr 요소)
			console.log('클릭한 행:', clickedRow.children[0].textContent, clickedRow);
		}
	});

	function fetchLeaveData() {
		fetch(`${pageContext}/attendance/loadleave.do`)
			.then(response => response.json())
			.then(data => {
				leaveData = data; // 전역 변수에 저장

				// 페이지 컨트롤 초기화
				initializePagination();

				// 첫 페이지 데이터 표시
				displayLeaveData();

				return data;
			})
			.then(data => {
				data.forEach(item => {
					try {
						// Parse dates properly
						const startDate = new Date(item.START_DATE);
						if (!isNaN(startDate.getTime())) {
							// Format directly as YYYYMMDD
							const formattedDate = `${startDate.getFullYear()}${String(startDate.getMonth() + 1).padStart(2, '0')}${String(startDate.getDate()).padStart(2, '0')}`;
							const cellId = `${formattedDate}-5`;
							const targetElement = document.getElementById(cellId);

							if (targetElement) {
								targetElement.textContent = "연차";
							}
						}
					} catch (error) {
						console.error("Error processing leave item:", item, error);
					}
				});
			})
			.catch(error => console.error("데이터 로드 중 오류 발생:", error));
	}

	// 모든 출근 데이터를 테이블에 표시하는 함수
	function displayAllAttendanceData(attendanceList) {
		console.log("모든 출근 데이터 표시 시작");

		attendanceList.forEach(item => {

			let attno = item.attno;
			if (attno && attno.startsWith('25')) {
				attno = '20' + attno;
			}

			//			console.log(attno);
			// 출근 시간 표시
			if (item.workin_time) {
				const workinTime = new Date(item.workin_time);
				const formattedWorkinTime = formatTimeString(workinTime);
				const workinCell = document.getElementById(`${attno}-0`);
				if (workinCell) {
					workinCell.textContent = formattedWorkinTime;
					//					console.log(`출근 시간 표시: ${attno}-0 => ${formattedWorkinTime}`);
				}
			}

			// 퇴근 시간 표시
			if (item.workout_time) {
				const workoutTime = new Date(item.workout_time);
				const formattedWorkoutTime = formatTimeString(workoutTime);
				const workoutCell = document.getElementById(`${attno}-1`);
				if (workoutCell) {
					workoutCell.textContent = formattedWorkoutTime;
					//					console.log(`퇴근 시간 표시: ${attno}-1 => ${formattedWorkoutTime}`);
				}

				// 근무 상태 표시
				if (item.work_status) {
					const statusCell = document.getElementById(`${attno}-5`);
					if (statusCell) {
						// 근무 상태 코드를 텍스트로 변환
						let statusText = '';
						switch (item.work_status) {
							case 'AT01':
								statusText = '정상';
								break;
							case 'AT02':
								statusText = '지각';
								statusCell.textContent = statusText;
								break;
							case 'AT03':
								statusText = '결근';
								statusCell.textContent = statusText;
								break;
							default:
								statusText = item.work_status;
						}
						//						console.log(`근무 상태 표시: ${attno}-5 => ${statusText}`);
					}
				}

				// 근무 시간 계산 및 표시 (출근 시간과 퇴근 시간이 모두 있는 경우)
				if (item.workin_time) {
					const workinTime = new Date(item.workin_time);
					const workoutTime = new Date(item.workout_time);
					const totalWorkedSeconds = Math.floor((workoutTime - workinTime) / 1000);
					const totalFormattedTime = formatTime(totalWorkedSeconds);

					const totalWorkTimeCell = document.getElementById(`${attno}-4`);
					if (totalWorkTimeCell) {
						totalWorkTimeCell.textContent = totalFormattedTime;
						//						console.log(`총 근무 시간 표시: ${attno}-4 => ${totalFormattedTime}`);
					}
				}
			}
		});

		console.log("모든 출근 데이터 표시 완료");
	}

	function loadMonthlyAttendanceData(year, month) {
		const empno = document.getElementById('empno').value;
		// YYYYMM 형식으로 변환
		const formattedYearMonth = `${year}${String(month).padStart(2, '0')}`;

		//				console.log("loadMonthlyAttendanceData formattedYearMonth", formattedYearMonth);
		//		console.log(`월 데이터 로드: ${formattedYearMonth}`);

		let data = { empno: empno, attno: formattedYearMonth };

		fetch('./getAttendance.do', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(data)
		})
			.then(response => response.json())
			.then(data => {
				//				console.log("월별 데이터 응답:", data);


				// 모든 출근 데이터 표시 함수 호출
				displayAllAttendanceData(data.map(res => ({
					attno: res.ATTNO,
					workin_time: res.WORKIN_TIME ? new Date(res.WORKIN_TIME - (new Date().getTimezoneOffset() * 60000)).toISOString().slice(0, 19).replace("T", " ") : null,
					workout_time: res.WORKOUT_TIME ? new Date(res.WORKOUT_TIME - (new Date().getTimezoneOffset() * 60000)).toISOString().slice(0, 19).replace("T", " ") : null,
					work_status: res.WORK_STATUS
				})));
			})
			.catch(error => console.error("월별 데이터 로드 오류:", error));
	}

	// 월 누적 근무시간 계산 및 표시 함수
	function updateMonthlyWorkHours() {
		const empno = document.getElementById('empno').value; // 사원번호 가져오기
		const today = new Date();
		//		const year = String(today.getFullYear()).slice(2); // '2025' → '25'
		const year = today.getFullYear(); // '2025' → '25'
		const month = String(today.getMonth() + 1).padStart(2, '0'); // 1 → '01'
		const formattedYearMonth = `${year}${month}`; // '2503' 형식

		//				console.log("updateMonthlyWorkHours formattedYearMonth", formattedYearMonth);


		let data = { empno: empno, attno: formattedYearMonth }; // 데이터 객체 수정

		//		console.log("updateMonthlyWorkHours data", data);

		if (!empno) {
			console.error("사원번호(empno)가 입력되지 않았습니다.");
			return;
		}

		fetch('./getAttendance.do', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(data)
		})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP 오류! 상태 코드: ${response.status}`);
				}
				return response.text(); // 먼저 텍스트로 변환해서 확인
			})
			.then(text => {
				//				console.log("updateMonthlyWorkHours text", text);

				if (!text || text.trim() === '') {
					console.warn("⚠ 서버에서 빈 응답이 왔습니다.");
					document.getElementById('workTotalTime').textContent = "00:00:00";
					return null;
				}
				//				console.log("📄 서버 응답 원본:", text);

				try {
					return JSON.parse(text);
				} catch (error) {
					console.error("JSON 파싱 오류:", error);
					console.log("파싱 실패한 텍스트:", text);
					document.getElementById('workTotalTime').textContent = "00:00:00";
					return null;
				}
			})
			.then(data => {
				if (!data || !Array.isArray(data) || data.length === 0) {
					console.warn("⚠ 근태 데이터가 없습니다.");
					document.getElementById('workTotalTime').textContent = "00:00:00";
					return;
				}

				//				console.log("데이터 첫 번째 항목:", data[0]); // 키 이름 확인을 위한 로그

				let totalSeconds = 0;
				data.forEach(record => {
					// 대문자 키 이름 사용 (서버 응답 키 이름에 맞게 수정)
					if (record.WORKIN_TIME && record.WORKOUT_TIME) {
						const inTime = new Date(record.WORKIN_TIME);
						const outTime = new Date(record.WORKOUT_TIME);
						if (!isNaN(inTime) && !isNaN(outTime)) {
							const diffSeconds = Math.floor((outTime - inTime) / 1000);
							if (diffSeconds > 0) {
								totalSeconds += diffSeconds;
							}
						}
					}
				});

				// 시간 포맷팅 코드 유지
				const hours = Math.floor(totalSeconds / 3600);
				const minutes = Math.floor((totalSeconds % 3600) / 60);
				const seconds = totalSeconds % 60;
				const formattedTime =
					String(hours).padStart(2, '0') + ':' +
					String(minutes).padStart(2, '0') + ':' +
					String(seconds).padStart(2, '0');
				document.getElementById('workTotalTime').textContent = formattedTime;

				//				 updateWorkTimeProgress();
			})
			.catch(error => console.error("월별 데이터 로드 오류:", error));

	}


	//// 월 누적 근무시간 진행률 표시 함수
	//function updateWorkTimeProgress() {
	//    // 월 누적 근무시간 값 가져오기 (형식: 00:00:00)
	//    const workTotalTimeElement = document.getElementById('workTotalTime');
	//    const workTotalTime = workTotalTimeElement.textContent.trim();
	//    
	//    console.log("workTotalTime",workTotalTime)
	//    
	//    // 시간 형식(00:00:00)에서 시간, 분, 초 추출
	//    const [hours, minutes, seconds] = workTotalTime.split(':').map(Number);
	//    
	//    // 최소 근무시간 (시간)
	//    const requiredHours = 152;
	//    
	//    // 최대 근무시간 (시간과 분)
	//    const maxHours = 209;
	//    const maxMinutes = 6;
	//    
	//    // 총 근무시간을 분으로 변환
	//    const currentTimeInMinutes = (hours * 60) + minutes;
	//    const maxTimeInMinutes = (maxHours * 60) + maxMinutes;
	//    
	//    // 달성률 계산 (%)
	//    const progressPercentage = Math.min(100, (currentTimeInMinutes / maxTimeInMinutes) * 100);
	//    
	//    // 최소 근무시간 위치 계산 (%)
	//    const requiredPercentage = (requiredHours * 60) / maxTimeInMinutes * 100;
	//    
	//    // 시간 표시 업데이트
	//    document.getElementById('currentHours').textContent = hours;
	//    document.getElementById('currentMinutes').textContent = minutes;
	//    
	//    // 최소 근무시간 선 위치 설정
	//    const requiredTime = document.getElementById('requiredTime');
	//    requiredTime.style.left = requiredPercentage + '%';
	//    requiredTime.textContent = `최소 ${requiredHours}h`;
	//    
	//    // 최대 근무시간 표시 업데이트
	//    document.querySelector('.max-time').textContent = `최대 ${maxHours}h ${maxMinutes}m`;
	//    
	//    // 프로그레스 바 업데이트
	//    const progressBar = document.getElementById('timeProgressBar');
	//    
	//    // 애니메이션 효과: 0%에서 progressPercentage까지 증가
	//    let currentProgress = 0;
	//    const animationInterval = setInterval(() => {
	//        if (currentProgress >= progressPercentage) {
	//            clearInterval(animationInterval);
	//        } else {
	//            currentProgress += 1;
	//            progressBar.style.width = currentProgress + '%';
	//            progressBar.setAttribute('aria-valuenow', currentProgress);
	//        }
	//    }, 15);
	//}

	//download
	const downloadBtns = document.getElementsByName("downloadBtn");
	Array.from(downloadBtns).forEach(btn => {
		btn.addEventListener('click', () => {
			// ID와 함께 data-type 속성 값도 전달
			downloadAttendanceAsExcel(btn.id);
		});
	});

	function downloadAttendanceAsExcel(id) {
		//		console.log("다운로드 버튼 클릭")
		// Get the table data

		var table;

		if (id == "attendance") {
			table = document.getElementById('attendanceTable');
		} else {
			table = document.getElementById('leaveTable');
		}
		if (!table) {
			alert('테이블을 찾을 수 없습니다.');
			return;
		}

		// Create a workbook and worksheet
		const wb = XLSX.utils.book_new();
		const ws = XLSX.utils.table_to_sheet(table);

		// Add the worksheet to the workbook
		if (id == "attendance") {
			XLSX.utils.book_append_sheet(wb, ws, '근태기록');
		} else {
			XLSX.utils.book_append_sheet(wb, ws, '연차사용기록');
		}

		// Get the current date and time for the filename
		const now = new Date();
		const year = now.getFullYear();
		const month = String(now.getMonth() + 1).padStart(2, '0');
		const dateStr = `${year}${month}`;

		// Generate the filename
		// Add the worksheet to the workbook
		var filename;
		if (id == "attendance") {
			filename = `근태기록_${dateStr}월.xlsx`;
		} else {
			filename = `연차기록_${dateStr}월.xlsx`;
		}

		// Save the workbook as an Excel file
		XLSX.writeFile(wb, filename);
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//	document.getElementById('profile-tab').addEventListener('click', function() {
	//		setLeave();
	//	});

	function EmployeeLevae() {
		setLeave();
		//		leaveList()

	}

	function setLeave() {

		fetch('./selectemployeeLeave.do', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
		})
			.then(response => {
				// HTTP 응답을 JSON으로 파싱
				return response.json();
			})
			.then(data => {
				console.log("연차", data);

				// 총 연차
				document.getElementById("totalleave").innerText = data.ANNUAL_LEAVE;
				//사용연차
				document.getElementById("useleave").innerText = data.USE_LEAVE;
				//잔여연차
				document.getElementById("stillleave").innerText = data.ANNUAL_COUNT;


			})
			.catch(error => {
				console.error('에러 발생:', error);
			});
	}


	// 연차 데이터를 저장할 전역 변수
	let leaveData = [];
	// 현재 페이지 상태 관리 변수
	let currentPage = 1;
	let entriesPerPage = 10;

	// 페이지네이션 초기화
	function initializePagination() {
		// 페이지당 항목 수 선택기에 이벤트 리스너 추가
		const selector = document.querySelector('.datatable-selector[name="leave-entries"]');
		if (selector) {
			selector.addEventListener('change', function() {
				entriesPerPage = parseInt(this.value);
				currentPage = 1; // 페이지 변경 시 첫 페이지로 이동
				displayLeaveData();
				updatePaginationControls();
			});
		}

		// 초기 설정
		updatePaginationControls();
	}

	// 페이지네이션 컨트롤 업데이트
	function updatePaginationControls() {
		const totalItems = leaveData.length;
		const totalPages = entriesPerPage === -1 ? 1 : Math.ceil(totalItems / entriesPerPage);

		// 정보 텍스트 업데이트
		const infoFrom = totalItems === 0 ? 0 : (entriesPerPage === -1 ? 1 : ((currentPage - 1) * entriesPerPage) + 1);
		const infoTo = entriesPerPage === -1 ? totalItems : Math.min(currentPage * entriesPerPage, totalItems);

		document.querySelector('.datatable-info-entries-from').textContent = infoFrom;
		document.querySelector('.datatable-info-entries-to').textContent = infoTo;
		document.querySelector('.datatable-info-entries-all').textContent = totalItems;

		// 페이지 버튼 생성
		const paginationList = document.querySelector('.datatable-pagination-list');
		paginationList.innerHTML = '';

		// 이전 페이지 버튼
		if (currentPage > 1) {
			const prevButton = document.createElement('li');
			prevButton.innerHTML = '<a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>';
			prevButton.classList.add('datatable-pagination-list-item');
			prevButton.addEventListener('click', function(e) {
				e.preventDefault();
				currentPage--;
				displayLeaveData();
				updatePaginationControls();
			});
			paginationList.appendChild(prevButton);
		}

		// 페이지 번호 버튼
		for (let i = 1; i <= totalPages; i++) {
			const pageButton = document.createElement('li');
			pageButton.innerHTML = `<a href="#">${i}</a>`;
			pageButton.classList.add('datatable-pagination-list-item');
			if (i === currentPage) {
				pageButton.classList.add('active');
			}
			pageButton.addEventListener('click', function(e) {
				e.preventDefault();
				currentPage = i;
				displayLeaveData();
				updatePaginationControls();
			});
			paginationList.appendChild(pageButton);
		}

		// 다음 페이지 버튼
		if (currentPage < totalPages) {
			const nextButton = document.createElement('li');
			nextButton.innerHTML = '<a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>';
			nextButton.classList.add('datatable-pagination-list-item');
			nextButton.addEventListener('click', function(e) {
				e.preventDefault();
				currentPage++;
				displayLeaveData();
				updatePaginationControls();
			});
			paginationList.appendChild(nextButton);
		}
	}
	// 연차 데이터 표시
	function displayLeaveData() {
		const tbody = document.querySelector('#leaveTable tbody');
		tbody.innerHTML = ''; // 테이블 내용 초기화


		// 현재 페이지에 표시할 데이터 범위 계산
		let startIndex = (currentPage - 1) * entriesPerPage;
		let endIndex = entriesPerPage === -1 ? leaveData.length : Math.min(startIndex + entriesPerPage, leaveData.length);

		// 해당 범위의 데이터만 표시
		for (let i = startIndex; i < endIndex; i++) {
			const item = leaveData[i];
			try {
				// 날짜 파싱
				var startDate = new Date(item.START_DATE);
				var endDate = new Date(item.END_DATE);

				// 날짜 포맷팅
				var formattedStartDate = `${startDate.getFullYear()}.${String(startDate.getMonth() + 1).padStart(2, '0')}.${String(startDate.getDate()).padStart(2, '0')}`;
				var formattedEndDate = `${endDate.getFullYear()}.${String(endDate.getMonth() + 1).padStart(2, '0')}.${String(endDate.getDate()).padStart(2, '0')}`;

				var formatDate = `${formattedStartDate} ~ ${formattedEndDate}`;

				// 사용일수 계산 (밀리초를 일수로 변환, 양 끝 날짜 포함)
				var usedDays = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1;

				// 에 행 추가테이블
				var newRow = document.createElement('tr');

				newRow.innerHTML = `
                <td>${item.LEAVE_TYPE || '연차'}</td>
                <td>${formatDate}</td>
                <td>${usedDays}일</td>
            `;

				tbody.appendChild(newRow);

			} catch (error) {
				console.error("Error processing leave item:", item, error);
			}
		}


	}

});