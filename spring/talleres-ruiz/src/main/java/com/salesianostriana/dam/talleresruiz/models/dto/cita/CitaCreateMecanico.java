package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.salesianostriana.dam.talleresruiz.validation.annotation.UserDniExists;
import lombok.*;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotEmpty;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class CitaCreateMecanico extends CitaCreateCliente {

    @UserDniExists(message = "{citaCreate.dni.userdniexists}")
    @NotEmpty(message = "{citaCreate.dni.notempty}")
    private String dniCliente;

}
