package dev.gmpark.bankbackend.vos;

import dev.gmpark.bankbackend.entities.AccountEntity;
import dev.gmpark.bankbackend.enums.ProductCategory;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class AccountVo extends AccountEntity {
    // FinancialProductEntity에서 JOIN하여 가져올 정보
    private String productName;
    private ProductCategory productCategory;
}
