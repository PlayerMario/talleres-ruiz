package com.salesianostriana.dam.talleresruiz.models.dto.mensaje;

import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaViews;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MensajeDto {

    @JsonView(CitaViews.DetallesCita.class)
    private String autor;

    @JsonView(CitaViews.DetallesCita.class)
    private String fechaHora;

    @JsonView(CitaViews.DetallesCita.class)
    private String mensaje;


    public MensajeDto(String autor, LocalDateTime fechaHora, String mensaje) {
        this.autor = autor;
        this.fechaHora = fechaHora.format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm"));
        this.mensaje = mensaje;
    }

}
