package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Mensaje;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.MensajeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MensajeService {

    private final MensajeRepository repository;

    public Mensaje add(Mensaje mensaje) {
        return repository.save(mensaje);
    }

    public void setearNullAutor(User user) {
        repository.findByAutor(user).forEach(mensaje -> {
            mensaje.setAutor(null);
        });
    }

}
