package com.salesianostriana.dam.talleresruiz.models.dto.user.security;

import com.salesianostriana.dam.talleresruiz.validation.annotation.PasswordSegura;
import com.salesianostriana.dam.talleresruiz.validation.annotation.VerificarPassword;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@VerificarPassword(password = "newPassword", verifyPassword = "verifyNewPassword", message = "{nuevoCliente.password.verificar}")
public class UserPassword {

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    private String oldPassword;

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    @PasswordSegura(message = "{nuevoCliente.password.passwordsegura}")
    private String newPassword;

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    private String verifyNewPassword;

}
