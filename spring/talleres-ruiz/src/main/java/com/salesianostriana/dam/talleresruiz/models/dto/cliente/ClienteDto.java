package com.salesianostriana.dam.talleresruiz.models.dto.cliente;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;
import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ClienteDto extends UserDto {

    @JsonView(ClienteViews.Master.class)
    private String vehiculo;
    @JsonView(ClienteViews.DetallesClientes.class)
    private List<CitaDto> citas;

    public ClienteDto(UUID id, String nombre, String username, String dni, String email, String tlf, String avatar,
                      String vehiculo) {
        super(id, nombre, username, dni, email, tlf, avatar);
        this.vehiculo = vehiculo;
    }

}
