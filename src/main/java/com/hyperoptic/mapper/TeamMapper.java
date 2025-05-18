package com.hyperoptic.mapper;

import com.hyperoptic.dto.TeamDto;
import com.hyperoptic.entity.Team;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface TeamMapper {

    @Mapping(source = "teamLead.id", target = "teamLeadId")
    TeamDto toDto(Team team);

    List<TeamDto> toDtoList(Iterable<Team> employees);
}
