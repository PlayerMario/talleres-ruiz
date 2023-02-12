package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CitaDto {

    @JsonView(ClienteViews.DetallesClientes.class)
    private String mecanico;
    @JsonView(ClienteViews.DetallesClientes.class)
    private String fechaHora;
    @JsonView(ClienteViews.DetallesClientes.class)
    private List<String> servicios;
    @JsonView(ClienteViews.DetallesClientes.class)
    private String estado;

}
