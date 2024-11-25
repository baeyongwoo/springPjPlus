package com.io.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Data
public class Criteria {
    private int pageNum;
    private int amount;
    private int offset;

    public Criteria() {
        this.pageNum = 1;
        this.amount = 10;
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public int getPageStart() {
        return (this.pageNum - 1) * amount;
    }
}