package com.salesianostriana.dam.talleresruiz.models.dto.user;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoViews;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class UserDto {

    @JsonView({MecanicoViews.DetallesMecanicos.class, ClienteViews.DetallesClientes.class, UserViews.Master.class})
    protected UUID id;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class, UserViews.Master.class})
    protected String nombre;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class, UserViews.Master.class})
    protected String username;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class})
    protected String dni;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class})
    protected String email;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class})
    protected String tlf;

    @JsonView({MecanicoViews.Master.class, ClienteViews.Master.class, UserViews.Master.class})
    protected String avatar;

    @JsonView({MecanicoViews.DetallesMecanicos.class, ClienteViews.DetallesClientes.class})
    protected List<String> roles;

    @JsonView(UserViews.Master.class)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    protected LocalDateTime createdAt;

    public static UserDto of(User user) {
        return UserDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .avatar(user.getAvatar())
                .nombre(user.getNombre())
                .createdAt(user.getCreatedAt())
                .build();
    }

}
