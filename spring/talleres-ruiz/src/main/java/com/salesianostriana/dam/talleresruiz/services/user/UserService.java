package com.salesianostriana.dam.talleresruiz.services.user;

import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteEdit;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;

    private final UserRepository repository;

    public List<User> findAll() {
        return repository.findAll();
    }

    public Optional<User> findById(UUID id) {
        return repository.findById(id);
    }

    public User add(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return repository.save(user);
    }

    public Optional<User> findByUsername(String username) {
        return repository.findFirstByUsername(username);
    }

    public boolean existsEmail(String email) {
        return repository.existsByEmail(email);
    }

    public boolean existsTlf(String tlf) {
        return repository.existsByTlf(tlf);
    }

    public boolean existsUsername(String username) {
        return repository.existsByUsername(username);
    }

    public boolean existsDNI(String dni) {
        return repository.existsByDni(dni);
    }

    public User editUserCliente(UUID id, ClienteEdit edit) {
        return repository.findById(id)
                .map(user -> {
                    user.setDni(edit.getDni());
                    user.setNombre(edit.getNombre());
                    user.setEmail(edit.getEmail());
                    user.setTlf(edit.getTlf());
                    return repository.save(user);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra al usuario con ID: " + id));

    }

}
