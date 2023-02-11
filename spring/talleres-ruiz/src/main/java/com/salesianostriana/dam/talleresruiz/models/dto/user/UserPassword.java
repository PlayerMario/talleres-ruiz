package com.salesianostriana.dam.talleresruiz.models.dto.user;

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
    //@PasswordNotEqual -> HACER ESTO EN EL MÉTODO DEL SERVICE DONDE SE HAGA EL CAMBIO, Y QUE ESTÉ ANOTADO CON ESTE @,
    // PARA PODER USAR EL ID DEL USUARIO, AQUÍ NO SE PODRÍA
    private String oldPassword;
    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    @PasswordSegura(message = "{nuevoCliente.password.passwordsegura}")
    //ANOTAR PARA QUE ESTA CONTRASEÑA SEA DISTINTA QUE LA ANTIGUA
    private String newPassword;

    @NotEmpty(message = "{nuevoCliente.password.notempty}")
    private String verifyNewPassword;

}
