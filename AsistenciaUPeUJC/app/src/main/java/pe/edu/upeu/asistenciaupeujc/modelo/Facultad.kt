package pe.edu.upeu.asistenciaupeujc.modelo

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "facultad")

data class Facultad(
    @PrimaryKey(autoGenerate = true)
    var id: Long,

    var estado: String,
    var iniciales: String,
    var nombrefac: String,
)

data class FacultadReport(
    @PrimaryKey(autoGenerate = true)
    var id: Long,

    var estado: String,
    var iniciales: String,
    var nombrefac: String,
)




