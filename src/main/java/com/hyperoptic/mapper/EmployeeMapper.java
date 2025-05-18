package com.hyperoptic.mapper;

import com.hyperoptic.dto.EmployeeDto;
import com.hyperoptic.entity.Employee;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface EmployeeMapper {
    @Mapping(source = "team.name", target = "team")
    @Mapping(source = "team.teamLead.name", target = "teamLead")
    EmployeeDto toDto(Employee employee);

    List<EmployeeDto> toDtoList(Iterable<Employee> employees);
}
