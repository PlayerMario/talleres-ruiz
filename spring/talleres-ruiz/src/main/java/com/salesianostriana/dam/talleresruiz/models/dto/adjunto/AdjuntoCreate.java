package com.salesianostriana.dam.talleresruiz.models.dto.adjunto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AdjuntoCreate {

    @NotEmpty(message = "{nuevoMensaje.mensaje.notempty}")
    private String contenido;

}
