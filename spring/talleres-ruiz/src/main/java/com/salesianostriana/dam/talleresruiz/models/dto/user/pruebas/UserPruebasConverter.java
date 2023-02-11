package com.salesianostriana.dam.talleresruiz.models.dto.user.pruebas;

import com.salesianostriana.dam.talleresruiz.models.user.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
@Component
public class UserPruebasConverter {

    public UserPruebas of(User usuario) {
        List<String> roles = new ArrayList<>();

        usuario.getRoles().forEach(rol -> {
            roles.add(rol.name());
        });

        return UserPruebas.builder()
                .id(usuario.getId())
                .nombre(usuario.getNombre())
                .username(usuario.getUsername())
                .password(usuario.getPassword())
                .dni(usuario.getDni())
                .email(usuario.getEmail())
                .tlf(usuario.getTlf())
                .avatar(usuario.getAvatar())
                .roles(roles)
                .build();
    }

}
