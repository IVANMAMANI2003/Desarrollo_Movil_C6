package pe.edu.upeu.asistencia.repositories;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.asistencia.models.Materialesx;

/**
 *
 * @author EP-Ing_Sist.-CALIDAD
 */
@Repository
// public interface MaterialesxRepository extends JpaRepository<Materialesx,
// Long> {
// Optional<Materialesx> findBynombreMateriale(String nombreMaterialesx);
// }

public interface MaterialesxRepository extends JpaRepository<Materialesx, Long> {

}