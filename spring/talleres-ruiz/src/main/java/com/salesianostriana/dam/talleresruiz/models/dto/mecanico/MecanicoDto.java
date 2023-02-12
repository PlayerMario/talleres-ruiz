package com.salesianostriana.dam.talleresruiz.models.dto.mecanico;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto;
import lombok.*;
import lombok.experimental.SuperBuilder;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MecanicoDto extends UserDto {}
