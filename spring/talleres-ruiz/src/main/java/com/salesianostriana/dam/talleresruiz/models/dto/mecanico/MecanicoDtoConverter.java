package com.salesianostriana.dam.talleresruiz.models.dto.mecanico;

import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class MecanicoDtoConverter {

    public MecanicoDto of(Mecanico mecanico) {
        List<String> roles = new ArrayList<>();

        mecanico.getUsuario().getRoles().forEach(rol -> {
            roles.add(rol.name());
        });

        return MecanicoDto.builder()
                .id(mecanico.getUsuario().getId())
                .nombre(mecanico.getUsuario().getNombre())
                .username(mecanico.getUsuario().getUsername())
                .dni(mecanico.getUsuario().getDni())
                .email(mecanico.getUsuario().getEmail())
                .tlf(mecanico.getUsuario().getTlf())
                .avatar(mecanico.getUsuario().getAvatar())
                .roles(roles)
                .build();
    }

}
