package com.jsh.erp.datasource.vo;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @Author jishenghua
 * @Date 2024-04-26 22:23
 */
public class InOutPriceVo {

    private Long id;

    private BigDecimal discountLastMoney;

    private BigDecimal totalPrice;

    private String type;

    private String subType;

    private Date operTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getDiscountLastMoney() {
        return discountLastMoney;
    }

    public void setDiscountLastMoney(BigDecimal discountLastMoney) {
        this.discountLastMoney = discountLastMoney;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSubType() {
        return subType;
    }

    public void setSubType(String subType) {
        this.subType = subType;
    }

    public Date getOperTime() {
        return operTime;
    }

    public void setOperTime(Date operTime) {
        this.operTime = operTime;
    }

}
