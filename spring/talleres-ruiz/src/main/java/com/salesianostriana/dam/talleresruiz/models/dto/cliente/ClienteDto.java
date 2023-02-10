package com.salesianostriana.dam.talleresruiz.models.dto.cliente;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.user.Roles;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.EnumSet;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ClienteDto {

    private UUID id;
    private String nombre;
    private String username;
    private String dni;
    private String email;
    private String tlf;
    //private List<String> roles;
    private String vehiculo;

    public static ClienteDto of(Cliente cliente) {
        /*cliente.getUsuario().getRoles().forEach(rol -> {
            roles.add(rol.name());
        });*/

        return ClienteDto.builder()
                .id(cliente.getUsuario().getId())
                .nombre(cliente.getUsuario().getNombre())
                .username(cliente.getUsuario().getUsername())
                .dni(cliente.getUsuario().getDni())
                .email(cliente.getUsuario().getEmail())
                .tlf(cliente.getUsuario().getTlf())
                //.roles(roles)
                .vehiculo(cliente.getMatricula() + "-" + cliente.getVehiculo())
                .build();
    }

}
