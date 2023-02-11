package com.salesianostriana.dam.talleresruiz.models.dto.cliente;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.user.Roles;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.validation.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotEmpty;
import java.util.EnumSet;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@VerificarPassword(password = "password", verifyPassword = "verifyPassword", message = "{nuevoCliente.password.verificar}")
public class ClienteCreate extends ClienteEdit {

    @NotEmpty(message = "{nuevoCliente.username.notempty}")
    @UniqueUsername(message = "{nuevoCliente.username.uniqueusername}")
    private String username;

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    @PasswordSegura(message = "{nuevoCliente.password.passwordsegura}")
    private String password;

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    private String verifyPassword;

    public User toUserCliente(ClienteCreate dto) {
        return User.builder()
                .username(dto.username)
                .password(dto.password)
                .dni(dto.dni)
                .nombre(dto.nombre)
                .email(dto.email)
                .tlf(dto.tlf)
                .avatar("https://robohash.org/" + dto.username)
                .roles(EnumSet.of(Roles.CLIENTE))
                .build();
    }

    public Cliente toCliente(ClienteCreate dto) {
        return Cliente.builder()
                .vehiculo(dto.vehiculo)
                .matricula(dto.matricula)
                .build();
    }

}
