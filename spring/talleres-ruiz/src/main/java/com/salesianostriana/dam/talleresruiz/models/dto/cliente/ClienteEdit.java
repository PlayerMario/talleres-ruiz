package com.salesianostriana.dam.talleresruiz.models.dto.cliente;

import com.salesianostriana.dam.talleresruiz.models.dto.user.UserEdit;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotBlank;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class ClienteEdit extends UserEdit {

    @NotBlank(message = "{nuevoCliente.vehiculo.notblank}")
    protected String vehiculo;

    @NotBlank(message = "{nuevoCliente.matricula.notblank}")
    //@UniqueMatricula(message = "{nuevoCliente.matricula.uniquematricula}") // Para que al editar no de error de que ya existe
    protected String matricula;

}
