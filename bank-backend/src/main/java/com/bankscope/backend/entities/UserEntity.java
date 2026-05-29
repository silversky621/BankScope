package com.bankscope.backend.entities;


import com.bankscope.backend.enums.Gender;
import lombok.*;

import java.io.Serializable;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode(of = "id")
public class UserEntity implements Serializable {
    private int id;
    private String name;
    private String email;
    private String residentNumber;
    private String identificationNumber;
    private Gender gender;
    private String password;
    private String userType;
    private String phone;
    private String age;
    private String grade;
    private String creditStatus;
    private Integer isTermsAgreed;

}
