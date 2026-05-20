package dev.gmpark.bankbackend.dtos;

import dev.gmpark.bankbackend.enums.MaturityTreatment;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DepositAccountRequestDto {
    private Integer taskId;
    private Integer productId;
    private Long amount;
    private Integer durationMonths;
    private String accountPassword;
    private String accountAlias;
    private Integer userId;
    private Long linkedAccountId;
    private MaturityTreatment maturityTreatment;

}

