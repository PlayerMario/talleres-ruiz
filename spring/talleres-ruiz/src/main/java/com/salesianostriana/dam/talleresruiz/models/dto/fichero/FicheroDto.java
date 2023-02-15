package com.salesianostriana.dam.talleresruiz.models.dto.fichero;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FicheroDto {

    private String nombre;
    private String uri;
    private String tipo;
    private long tam;


    public static FicheroDto of(MultipartFile fichero, String nombre, String uri) {
        return FicheroDto.builder()
                .nombre(nombre)
                .uri(uri)
                .tipo(fichero.getContentType())
                .tam(fichero.getSize())
                .build();
    }

}
