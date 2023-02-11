package com.salesianostriana.dam.talleresruiz.models.dto.user.pruebas;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserPruebas {

    private UUID id;
    private String username;
    private String password;
    private String dni;
    private String nombre;
    private String email;
    private String tlf;
    private String avatar;
    private List<String> roles;

}
