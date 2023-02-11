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

    @JsonView(ClienteViews.MostrarDetalles.class)
    private String mecanico;
    @JsonView(ClienteViews.MostrarDetalles.class)
    private String fechaHora;
    @JsonView(ClienteViews.MostrarDetalles.class)
    private List<String> servicios;
    @JsonView(ClienteViews.MostrarDetalles.class)
    private String estado;

}
