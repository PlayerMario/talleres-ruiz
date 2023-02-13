package com.salesianostriana.dam.talleresruiz.services.user;

import com.salesianostriana.dam.talleresruiz.errors.exceptions.OldPasswordEqualException;
import com.salesianostriana.dam.talleresruiz.errors.exceptions.PasswordEqualException;
import com.salesianostriana.dam.talleresruiz.models.dto.user.UserEdit;
import com.salesianostriana.dam.talleresruiz.models.dto.user.security.UserPassword;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import com.salesianostriana.dam.talleresruiz.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.time.LocalDateTime;
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

    public User findByIdCheck(UUID id) {
        return repository.findById(id).orElseThrow(() ->
                new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public User add(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return repository.save(user);
    }

    public User findByUsername(String username) throws UsernameNotFoundException {
        return repository.findFirstByUsername(username).orElseThrow(() ->
                new UsernameNotFoundException("No se encuentra al usuario: " + username));
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

    public User editUser(UUID id, UserEdit edit) {
        return repository.findById(id)
                .map(user -> {
                    user.setNombre(edit.getNombre());
                    user.setEmail(edit.getEmail());
                    user.setTlf(edit.getTlf());
                    return repository.save(user);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public User editPassword(UUID id, UserPassword userPassword) {
        return repository.findById(id)
                .map(user -> {
                    if (passwordValidator(user, userPassword)) {
                        user.setPassword(passwordEncoder.encode(userPassword.getNewPassword()));
                        user.setLastPasswordChangeAt(LocalDateTime.now());
                    }
                    return repository.save(user);
                }).orElseThrow(() ->
                        new EntityNotFoundException("No se encuentra al usuario con ID: " + id));
    }

    public boolean passwordValidator(User user, UserPassword userPassword) {
        if (passwordEncoder.matches(userPassword.getNewPassword(), user.getPassword())) {
            throw new PasswordEqualException();
        } else if (!passwordEncoder.matches(userPassword.getOldPassword(), user.getPassword())) {
            throw new OldPasswordEqualException();
        } else {
            return true;
        }
    }


}
