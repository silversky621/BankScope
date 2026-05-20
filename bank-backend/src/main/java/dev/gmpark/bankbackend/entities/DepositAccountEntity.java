package dev.gmpark.bankbackend.entities;


import dev.gmpark.bankbackend.enums.MaturityTreatment;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DepositAccountEntity {
        private Long accountId;
        private Long linkedAccountId;
        private MaturityTreatment maturityTreatment;
}
