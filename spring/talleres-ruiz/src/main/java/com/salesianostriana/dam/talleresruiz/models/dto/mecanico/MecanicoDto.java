package com.salesianostriana.dam.talleresruiz.models.dto.mecanico;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MecanicoDto extends UserDto {

    public MecanicoDto(UUID id, String nombre, String username, String dni, String email, String tlf, String avatar) {
        super(id, nombre, username, dni, email, tlf, avatar);
    }

}
