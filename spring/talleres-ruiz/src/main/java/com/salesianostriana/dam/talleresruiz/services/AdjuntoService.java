package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.models.Adjunto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.AdjuntoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdjuntoService {

    private final AdjuntoRepository repository;

    public Adjunto add(Adjunto adjunto) {
        return repository.save(adjunto);
    }

    public void setearNullAutor(User user) {
        repository.findByAutor(user).forEach(adjunto -> {
            adjunto.setAutor(null);
        });
    }

}
