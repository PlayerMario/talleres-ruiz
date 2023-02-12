package com.salesianostriana.dam.talleresruiz.models.dto.user;

import com.salesianostriana.dam.talleresruiz.validation.annotation.UniqueEmail;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UniqueTlf;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class UserEdit {

    @NotEmpty(message = "{nuevoCliente.nombre.notempty}")
    protected String nombre;

    @Email(message = "{nuevoCliente.email.email}")
    @NotEmpty(message = "{nuevoCliente.email.notempty}")
    @UniqueEmail(message = "{nuevoCliente.email.uniqueemail}")
    protected String email;

    @NotEmpty(message = "{nuevoCliente.tlf.notempty}")
    @UniqueTlf(message = "{nuevoCliente.tlf.uniquetlf}")
    protected String tlf;

}
