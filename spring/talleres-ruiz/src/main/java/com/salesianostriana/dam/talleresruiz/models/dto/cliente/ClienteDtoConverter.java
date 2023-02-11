package com.salesianostriana.dam.talleresruiz.models.dto.cliente;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
@Component
public class ClienteDtoConverter {

    public ClienteDto of(Cliente cliente) {
        List<String> roles = new ArrayList<>();

        cliente.getUsuario().getRoles().forEach(rol -> {
            roles.add(rol.name());
        });

        return ClienteDto.builder()
                .id(cliente.getUsuario().getId())
                .nombre(cliente.getUsuario().getNombre())
                .username(cliente.getUsuario().getUsername())
                .dni(cliente.getUsuario().getDni())
                .email(cliente.getUsuario().getEmail())
                .tlf(cliente.getUsuario().getTlf())
                .avatar(cliente.getUsuario().getAvatar())
                .roles(roles)
                .vehiculo(cliente.getMatricula() + "-" + cliente.getVehiculo())
                .citas(cliente.getCitas())
                .build();
    }

}
