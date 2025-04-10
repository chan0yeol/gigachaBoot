package com.giga.gw.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class PageDto {
    private int page;
    private int countList;
    private int totalCount;

    private int countPage;
    private int totalPage;
    private int stagePage;
    private int endPage;

    public void setPage(int page) {
        if (totalPage < page) {
            page = totalPage;
        }
        this.page = page;
    }

    public void setTotalPage(int totalPage) {
        int totalPageRes = totalCount / countList;
        if (totalCount % countList > 0) {
            totalPageRes++;
        }
        this.totalPage = totalPageRes;
    }

    public void setStagePage(int stagePage) {
        int stagePageRes = ((page - 1) / countPage) * countPage + 1;
        this.stagePage = stagePageRes;
    }

    public void setEndPage(int endPage) {
        int endPageRes = stagePage + countPage - 1;
        if (endPageRes > totalPage) {
            endPageRes = totalPage;
        }
        this.endPage = endPageRes;
    }
}