package com.salesianostriana.dam.talleresruiz.models.dto.user;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.user.Roles;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.validation.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.EnumSet;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@VerificarPassword(password = "password", verifyPassword = "verifyPassword", message = "{nuevoUsuario.password.verificar}")
public class CrearUser {

    @NotEmpty(message = "{nuevoUsuario.username.notempty}")
    @UniqueUsername(message = "{nuevoUsuario.username.uniqueusername}")
    private String username;

    @NotEmpty(message = "{nuevoUsuario.password.notempty}")
    @PasswordSegura(message = "{nuevoUsuario.password.passwordsegura}")
    private String password;

    @NotEmpty(message = "{nuevoUsuario.password.notempty}")
    private String verifyPassword;

    @NotEmpty(message = "{nuevoUsuario.dni.notempty}")
    @UniqueDNI(message = "{nuevoUsuario.dni.uniquedni}")
    private String dni;

    @NotEmpty(message = "{nuevoUsuario.nombre.notempty}")
    private String nombre;

    @Email(message = "{nuevoUsuario.email.email}")
    @NotEmpty(message = "{nuevoUsuario.email.notempty}")
    @UniqueEmail(message = "{nuevoUsuario.email.uniqueemail}")
    private String email;

    @NotEmpty(message = "{nuevoUsuario.tlf.notempty}")
    @UniqueTlf(message = "{nuevoUsuario.tlf.uniquetlf}")
    private String tlf;

    @NotBlank(message = "{nuevoUsuario.vehiculo.notblank}")
    private String vehiculo;

    @NotBlank(message = "{nuevoUsuario.matricula.notblank}")
    @UniqueMatricula(message = "{nuevoUsuario.matricula.uniquematricula}")
    private String matricula;

    public User toUserCliente(CrearUser dto) {
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

    public Cliente toCliente(CrearUser dto) {
        return Cliente.builder()
                .vehiculo(dto.vehiculo)
                .matricula(dto.matricula)
                .build();
    }

}
