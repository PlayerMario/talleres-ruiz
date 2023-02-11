package com.salesianostriana.dam.talleresruiz.models.dto.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserLogin {

    @NotEmpty(message = "{userlogin.username.notempty}")
    private String username;
    @NotEmpty(message = "{userlogin.password.notempty}")
    private String password;

}
