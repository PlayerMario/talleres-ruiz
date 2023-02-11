package com.salesianostriana.dam.talleresruiz.models.dto.cliente;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.user.Roles;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.validation.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.EnumSet;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class ClienteEdit {

    @NotEmpty(message = "{nuevoCliente.dni.notempty}")
    @UniqueDNI(message = "{nuevoCliente.dni.uniquedni}")
    protected String dni;

    @NotEmpty(message = "{nuevoCliente.nombre.notempty}")
    protected String nombre;

    @Email(message = "{nuevoCliente.email.email}")
    @NotEmpty(message = "{nuevoCliente.email.notempty}")
    @UniqueEmail(message = "{nuevoCliente.email.uniqueemail}")
    protected String email;

    @NotEmpty(message = "{nuevoCliente.tlf.notempty}")
    @UniqueTlf(message = "{nuevoCliente.tlf.uniquetlf}")
    protected String tlf;

    @NotBlank(message = "{nuevoCliente.vehiculo.notblank}")
    protected String vehiculo;

    @NotBlank(message = "{nuevoCliente.matricula.notblank}")
    @UniqueMatricula(message = "{nuevoCliente.matricula.uniquematricula}")
    protected String matricula;


    public User toUserCliente(ClienteEdit dto) {
        return User.builder()
                .dni(dto.dni)
                .nombre(dto.nombre)
                .email(dto.email)
                .tlf(dto.tlf)
                .roles(EnumSet.of(Roles.CLIENTE))
                .build();
    }

    public Cliente toCliente(ClienteEdit dto) {
        return Cliente.builder()
                .vehiculo(dto.vehiculo)
                .matricula(dto.matricula)
                .build();
    }

}
