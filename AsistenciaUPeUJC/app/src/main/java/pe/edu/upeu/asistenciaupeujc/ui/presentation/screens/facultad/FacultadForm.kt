package pe.edu.upeu.asistenciaupeujc.ui.presentation.screens.facultad

import android.annotation.SuppressLint
import android.os.Looper
import android.util.Log
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row

import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.github.k0shk0sh.compose.easyforms.BuildEasyForms
import com.github.k0shk0sh.compose.easyforms.EasyFormsResult
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.gson.Gson
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import pe.edu.upeu.asistenciaupeujc.modelo.ComboModel
import pe.edu.upeu.asistenciaupeujc.modelo.Facultad
import pe.edu.upeu.asistenciaupeujc.ui.navigation.Destinations
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.Spacer
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.AccionButtonCancel
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.AccionButtonSuccess
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.ComboBox
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.ComboBoxTwo
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.DatePickerCustom
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.DropdownMenuCustom
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.MyFormKeys
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.NameTextField
import pe.edu.upeu.asistenciaupeujc.ui.presentation.components.form.TimePickerCustom

@Composable
fun FacultadForm(
    text: String,
    darkMode: MutableState<Boolean>,
    navController: NavHostController,
    viewModel: FacultadFormViewModel= hiltViewModel()
) {
    val FacultadD:Facultad
    if (text!="0"){
        FacultadD = Gson().fromJson(text, Facultad::class.java)
    }else{
        FacultadD= Facultad(0,"","", "")
    }
    val isLoading by viewModel.isLoading.observeAsState(false)
    formulario(FacultadD.id!!,
        darkMode,
        navController,
        FacultadD,
        viewModel
    )

}



@OptIn(ExperimentalMaterial3Api::class)
@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter", "MissingPermission",
    "CoroutineCreationDuringComposition"
)
@Composable
fun formulario(id:Long,
               darkMode: MutableState<Boolean>,
               navController: NavHostController,
               facultad:Facultad,
               viewModel: FacultadFormViewModel){

    Log.i("VERRR", "d: "+facultad?.id!!)
    val person=Facultad(0,"","", "")
    val context = LocalContext.current
    val scope = rememberCoroutineScope()

    var locationCallback: LocationCallback? = null
    var fusedLocationClient: FusedLocationProviderClient? = null
    fusedLocationClient = LocationServices.getFusedLocationProviderClient(
        context)
    locationCallback = object : LocationCallback() {
        override fun onLocationResult(p0: LocationResult) {
            for (lo in p0.locations) {
                Log.e("LATLONX", "Lat: ${lo.latitude} Lon: ${lo.longitude}")
                person.estado=lo.latitude.toString()
                person.nombrefac=lo.longitude.toString()
            }
        }
    }
    scope.launch{
        val locationRequest = LocationRequest.create().apply {
            interval = 10000
            fastestInterval = 5000
            priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        }
        fusedLocationClient!!.requestLocationUpdates(locationRequest, locationCallback, Looper.getMainLooper())

        Log.e("LATLON", "Lat: ${person.estado} Lon: ${person.nombrefac}")
        delay(1500L)
        if (fusedLocationClient != null) {
            fusedLocationClient!!.removeLocationUpdates(locationCallback);
            fusedLocationClient = null;
        }

    }

    Scaffold(modifier = Modifier.padding(top = 60.dp, start = 16.dp, end = 16.dp, bottom = 32.dp)){
        BuildEasyForms { easyForm ->
            Column(modifier = Modifier.verticalScroll(rememberScrollState())) {
                NameTextField(easyForms = easyForm, text =facultad?.nombrefac!!,"Nomb. Facultad:", MyFormKeys.NAME )
                var listE = listOf(
                    ComboModel("Activo","Activo"),
                    ComboModel("Desactivo","Desactivo"),
                )
                ComboBox(easyForm = easyForm, "Estado:", facultad?.estado!!, listE)

                var listEv = listOf(
                    ComboModel("SI","SI"),
                    ComboModel("NO","NO"),
                )



                NameTextField(easyForms = easyForm, text = facultad?.iniciales!!, "Iniciales:", MyFormKeys.INICIALES )

                Row(Modifier.align(Alignment.CenterHorizontally)){
                    AccionButtonSuccess(easyForms = easyForm, "Guardar", id){
                        val lista=easyForm.formData()
                        person.nombrefac=(lista.get(0) as EasyFormsResult.StringResult).value
                        person.estado=splitCadena((lista.get(1) as EasyFormsResult.GenericStateResult<String>).value)
                        person.iniciales=(lista.get(2) as EasyFormsResult.StringResult).value

                        if (id==0.toLong()){
                            Log.i("AGREGAR", "NF:"+ person.nombrefac)
                            Log.i("AGREGAR", "Est:"+ person.estado)
                            Log.i("AGREGAR", "In:"+ person.iniciales)
                            viewModel.addFacultad(person)
                        }else{
                            person.id=id
                            Log.i("MODIFICAR", "M:"+person)
                            viewModel.editFacultad(person)
                        }
                        navController.navigate(Destinations.FacultadUI.route)
                    }
                    Spacer()
                    AccionButtonCancel(easyForms = easyForm, "Cancelar"){
                        navController.navigate(Destinations.FacultadUI.route)
                    }
                }
            }
        }
    }
}


fun splitCadena(data:String):String {
    return if (data != "") data.split("-")[0] else ""
}