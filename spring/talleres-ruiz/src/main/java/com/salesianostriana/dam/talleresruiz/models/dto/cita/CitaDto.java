package com.salesianostriana.dam.talleresruiz.models.dto.cita;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import com.salesianostriana.dam.talleresruiz.models.dto.adjunto.AdjuntoDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CitaDto {

    @JsonView({CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private Long id;

    @JsonView({CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private String mecanico;

    @JsonView(CitaViews.Master.class)
    private String cliente;

    @JsonView(CitaViews.Master.class)
    private String vehiculo;

    @JsonView({CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private String fechaHora;

    @JsonView({CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private String estado;

    @JsonView(CitaViews.DetallesCita.class)
    private List<AdjuntoDto> chat;


    public CitaDto(Long id, String cliente, String vehiculo, LocalDateTime fechaHora, String estado) {
        this.id = id;
        this.cliente = cliente;
        this.vehiculo = vehiculo;
        this.fechaHora = fechaHora.format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm"));
        this.estado = estado;
    }

    public CitaDto(Long id, String mecanico, String cliente, String vehiculo, LocalDateTime fechaHora, String estado) {
        this.id = id;
        this.mecanico = mecanico;
        this.cliente = cliente;
        this.vehiculo = vehiculo;
        this.fechaHora = fechaHora.format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm"));
        this.estado = estado;
    }

}
