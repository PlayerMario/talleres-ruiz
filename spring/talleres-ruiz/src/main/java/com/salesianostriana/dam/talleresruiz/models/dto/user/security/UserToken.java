package com.salesianostriana.dam.talleresruiz.models.dto.user.security;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserToken extends UserDto {

    private String token;

    public UserToken(UserDto dto) {
        id = dto.getId();
        username = dto.getUsername();
        nombre = dto.getNombre();
        avatar = dto.getAvatar();
        createdAt = dto.getCreatedAt();
    }

    public static UserToken of (User user, String token) {
        UserToken result = new UserToken(UserDto.of(user));
        result.setToken(token);
        return result;
    }

}
