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
    private String avatar;
    private List<String> roles;
    private String vehiculo;

}
