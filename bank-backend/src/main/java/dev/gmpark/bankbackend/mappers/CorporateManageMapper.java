package dev.gmpark.bankbackend.mappers;

import dev.gmpark.bankbackend.entities.CorporateManagementEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CorporateManageMapper {
    List<CorporateManagementEntity> selectAll();
    CorporateManagementEntity selectById(int id);
    void insert(CorporateManagementEntity corporateManage);
    void update(CorporateManagementEntity corporateManage);
    void delete(int id);
}
