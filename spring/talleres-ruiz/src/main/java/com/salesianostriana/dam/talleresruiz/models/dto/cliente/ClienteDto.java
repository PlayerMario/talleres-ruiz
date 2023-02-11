package com.salesianostriana.dam.talleresruiz.models.dto.cliente;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.Cita;
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
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ClienteDto {

    @JsonView(ClienteViews.MostrarDetalles.class)
    private UUID id;
    @JsonView(ClienteViews.Master.class)
    private String nombre;
    @JsonView(ClienteViews.Master.class)
    private String username;
    @JsonView(ClienteViews.Master.class)
    private String dni;
    @JsonView(ClienteViews.Master.class)
    private String email;
    @JsonView(ClienteViews.Master.class)
    private String tlf;
    @JsonView(ClienteViews.Master.class)
    private String avatar;
    @JsonView(ClienteViews.MostrarDetalles.class)
    private List<String> roles;
    @JsonView(ClienteViews.Master.class)
    private String vehiculo;
    @JsonView(ClienteViews.MostrarDetalles.class)
    private List<Cita> citas;

}
