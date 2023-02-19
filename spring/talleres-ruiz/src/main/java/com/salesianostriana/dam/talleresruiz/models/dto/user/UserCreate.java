package com.salesianostriana.dam.talleresruiz.models.dto.user;

import com.salesianostriana.dam.talleresruiz.models.user.Roles;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.validation.annotation.PasswordSegura;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UniqueDNI;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UniqueUsername;
import com.salesianostriana.dam.talleresruiz.validation.annotation.VerificarPassword;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotEmpty;
import java.util.EnumSet;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@VerificarPassword(password = "password", verifyPassword = "verifyPassword", message = "{nuevoCliente.password.verificar}")
public class UserCreate extends UserEdit {

    @NotEmpty(message = "{nuevoCliente.username.notempty}")
    @UniqueUsername(message = "{nuevoCliente.username.uniqueusername}")
    private String username;

    @NotEmpty(message = "{nuevoCliente.dni.notempty}")
    @UniqueDNI(message = "{nuevoCliente.dni.uniquedni}")
    protected String dni;

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    @PasswordSegura(message = "{nuevoCliente.password.passwordsegura}")
    private String password;

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    private String verifyPassword;


    public User toUserAdminMec(UserCreate dto, int opcion) {
        User user = User.builder()
                .username(dto.username)
                .password(dto.password)
                .dni(dto.dni)
                .nombre(dto.nombre)
                .email(dto.email)
                .tlf(dto.tlf)
                .avatar("user.png")
                .build();
        switch (opcion) {
            case 1 -> user.setRoles(EnumSet.of(Roles.ADMIN, Roles.MEC));
            case 2 -> user.setRoles(EnumSet.of(Roles.MEC));
        }
        return user;
    }
}
