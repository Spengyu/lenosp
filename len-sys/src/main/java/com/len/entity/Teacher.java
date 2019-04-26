package com.len.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by shangpengyu on 2019/4/24.
 */
@Data
@Table(name ="t_teacher")
public class Teacher {

    @Id
    @Column(name = "teac_id")
    private Integer teacId;

    @Column(name = "teac_name")
    private String teacName;

    @Column(name = "teac_age")
    private Integer teacAge;

    @Column(name = "teac_sex")
    private String teacSex;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name="teac_bir")
    private Date teacBir;

    @Column(name = "teac_jineng")
    private String teacJineng;

}
