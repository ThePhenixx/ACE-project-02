package controller;

import jakarta.ejb.EJB;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sessions.TrackerFacade;
import sessions.VehiculeFacade;
import sessions.VehiculetrackerFacade;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sound.midi.Track;

import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;

import entities.Tracker;
import entities.Vehicule;
import entities.Vehiculetracker;
import entities.VehiculetrackerPK;

/**
 * Servlet implementation class VehiculeController
 */
public class VehiculeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private VehiculeFacade vehiculeFacade;
	
	@EJB
	private TrackerFacade trackerFacade;
	
	@EJB
	private VehiculetrackerFacade vehiculetrackerFacade;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VehiculeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getTrackers".equals(action)) {

            // Build a JSON array
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();

            
            List<Tracker> list = trackerFacade.findAll();
            List<Integer> trackerIdList = new ArrayList<Integer>();
            
            for(Tracker tracker: list) {
            	
            	Boolean inUse = false;
            	List<Vehiculetracker> vt_List = vehiculetrackerFacade.findAll();
            	
            	for(Vehiculetracker vt: vt_List) {
            		if(vt.getDateFin()==null && vt.getTracker1().getId()==tracker.getId()) {
            			inUse = true;
            		}
            	}
            	if( !inUse ) {
            		trackerIdList.add(tracker.getId());
        			JsonObjectBuilder
                    objectBuilder = Json.createObjectBuilder()
                        .add("id", tracker.getId())
                        .add("simNumber", tracker.getSimNumber());
                    arrayBuilder.add(objectBuilder);
            	}
        	}
            

            JsonArray jsonArray = arrayBuilder.build();

            // Convert JSON array to string
            String json = jsonArray.toString();

            response.setContentType("application/json");
            response.getWriter().write(json);
        }
        
        else if("removeTracker".equals(action)) {
        	
        	int id= Integer.parseInt(request.getParameter("id"));
        	
        	List<Vehiculetracker> list = vehiculetrackerFacade.findAll();
        	for(Vehiculetracker vt: list) {
        		if(vt.getVehicule1().getId()==id && vt.getDateFin()==null) {
        			vt.setDateFin(new Date());
        			vehiculetrackerFacade.edit(vt);
        		}
        	}
        	
        	response.sendRedirect("vehiculeUpdate.jsp");
        	
        }
        
        else if("deleteVehicule".equals(action)) {
        	
        	int id= Integer.parseInt(request.getParameter("id"));
        	Vehicule vehicule = vehiculeFacade.find(id);
        	
        	List<Vehiculetracker> list = vehiculetrackerFacade.findAll();
        	
        	for(Vehiculetracker vt: list) {
        		if(vt.getVehicule1().getId()==id && vt.getDateFin()==null) {
            		vt.setDateFin(new Date());
            		vehiculetrackerFacade.edit(vt);
        		}
        	}
        	
        	vehicule.setDeleted(true);
        	vehiculeFacade.edit(vehicule);
        	
        	response.sendRedirect("vehiculesList.jsp");
        	
        }
        
        
        else if ("getVehicule".equals(action)) {
        	
        	// Build a JSON array
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            
        	int id= Integer.parseInt(request.getParameter("id"));
        	Vehicule v = vehiculeFacade.find(id);
        	
        	List<Tracker> trackers = trackerFacade.findAll();
        	Tracker currentTracker = null;
            
            for (Tracker tracker : trackers) {

            	List<Vehiculetracker> list = vehiculetrackerFacade.findAll();
            	for(Vehiculetracker vt: list) {
            		if(vt.getDateFin()==null && vt.getVehicule1().getId()==id) {
            			currentTracker = vt.getTracker1();
            		}
            	}
            	if(currentTracker == null) {
            		JsonObjectBuilder objectBuilder = Json.createObjectBuilder()
                			.add("id", id)
                			.add("matricule", v.getMatricule())
                			.add("trackerId", "0")
                			.add("simNumber", "none");
                	arrayBuilder.add(objectBuilder);
            	}
            	else {
            		JsonObjectBuilder objectBuilder = Json.createObjectBuilder()
                			.add("id", id)
                			.add("matricule", v.getMatricule())
                			.add("trackerId", currentTracker.getId())
                			.add("simNumber", currentTracker.getSimNumber());
                	arrayBuilder.add(objectBuilder);
            	}
            }
            
        	JsonArray jsonArray = arrayBuilder.build();
        	String json = jsonArray.toString();

            response.setContentType("application/json");
            response.getWriter().write(json);
        } 
        
        
        else if ("getHistory".equals(action)) {
        	
        	// Build a JSON array
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            
        	int id= Integer.parseInt(request.getParameter("id"));
        	Vehicule v = vehiculeFacade.find(id);
        	
        	List<Tracker> trackers = trackerFacade.findAll();
        	Tracker currentTracker = null;

        	List<Vehiculetracker> list = vehiculetrackerFacade.findAll();
        	for(Vehiculetracker vt: list) {
        		if(vt.getDateFin()==null && vt.getVehicule1().getId()==id) {
        			JsonObjectBuilder objectBuilder = Json.createObjectBuilder()
                			.add("id", id)
                			.add("matricule", v.getMatricule())
                			.add("simNumber", vt.getTracker1().getSimNumber())
                			.add("dateDebut", vt.getVehiculetrackerPK().getDateDebut().toString())
                			.add("dateFin", "-");
                	arrayBuilder.add(objectBuilder);
        		}
        		else if(vt.getDateFin()!=null && vt.getVehicule1().getId()==id) {
        			JsonObjectBuilder objectBuilder = Json.createObjectBuilder()
                			.add("id", id)
                			.add("matricule", v.getMatricule())
                			.add("simNumber", vt.getTracker1().getSimNumber())
                			.add("dateDebut", vt.getVehiculetrackerPK().getDateDebut().toString())
                			.add("dateFin", vt.getDateFin().toString());
                	arrayBuilder.add(objectBuilder);
        		}
        	}
            
        	JsonArray jsonArray = arrayBuilder.build();
        	String json = jsonArray.toString();

            response.setContentType("application/json");
            response.getWriter().write(json);
        } 
        
        
        else if("updateVehicule".equals(action)) {
        	
            int id = Integer.parseInt(request.getParameter("id"));
            String newMatricule = request.getParameter("matricule");
            int trackerId = Integer.parseInt(request.getParameter("trackerId"));
        	Vehicule vehicule = vehiculeFacade.find(id);
        	
        	if(vehicule.getMatricule() != newMatricule && newMatricule != "") {
        		vehicule.setMatricule(newMatricule);
        		vehiculeFacade.edit(vehicule);
        	}
        	
        	if(trackerId != 0) {
        		List<Vehiculetracker> vt_list = vehiculetrackerFacade.findAll();
        		
        		Boolean newTracker = true;
        		
        		for(Vehiculetracker vt: vt_list) {
        			if(vt.getDateFin() == null && vt.getVehicule1().getId()==vehicule.getId()) {
        				newTracker = false;
        			}
        		}
        		
        		if( newTracker ) {
        			VehiculetrackerPK pk = new VehiculetrackerPK();
                	pk.setDateDebut(new Date());
                	pk.setVehicule(vehicule.getId());
                	pk.setTracker(trackerId);
                	
                	Tracker tracker = trackerFacade.find(trackerId);
                	
                	Vehiculetracker vehiculetracker = new Vehiculetracker();
                	vehiculetracker.setVehiculetrackerPK(pk);
                	vehiculetracker.setDateFin(null);
                	vehiculetracker.setVehicule1(vehicule);
                	vehiculetracker.setTracker1(tracker);
                	vehiculetrackerFacade.create(vehiculetracker);
        		}
        	}
        	
        	response.sendRedirect("vehiculeUpdate.jsp?id="+id);
        }
        
        else if ("getVehicules".equals(action)) {
        	
            List<Vehicule> vehicules = vehiculeFacade.findAll();

            // Build a JSON array
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            for (Vehicule vehicule : vehicules) {
            	
            	if(vehicule.getDeleted()==false) {
            		Vehiculetracker vehiculetracker = null;
                	
                	List<Vehiculetracker> list = vehicule.getVehiculetrackerList();
                	for(Vehiculetracker vt : list) {
                		if(vt.getDateFin() == null) {
                			vehiculetracker = vt;
                			break;
                		}
                	}
                	if(vehiculetracker != null) {
                		JsonObjectBuilder
                        objectBuilder = Json.createObjectBuilder()
                            .add("id", vehicule.getId())
                            .add("matricule", vehicule.getMatricule())
                            .add("tracker", vehiculetracker.getTracker1().getSimNumber())
                            .add("dateDebut", vehiculetracker.getVehiculetrackerPK().getDateDebut().toString());
                        arrayBuilder.add(objectBuilder);
                	}
                	else {
                		JsonObjectBuilder
                        objectBuilder = Json.createObjectBuilder()
                            .add("id", vehicule.getId())
                            .add("matricule", vehicule.getMatricule())
                            .add("tracker", "-")
                            .add("dateDebut", "-");
                        arrayBuilder.add(objectBuilder);
                	}
            	}
                
            }
            JsonArray jsonArray = arrayBuilder.build();

            // Convert JSON array to string
            String json = jsonArray.toString();

            response.setContentType("application/json");
            response.getWriter().write(json);
        }
        
        
        else {
        	
        	String matricule = request.getParameter("matricule");
        	int trackerId = Integer.parseInt(request.getParameter("tracker"));
        	
        	Vehicule v = new Vehicule();
        	v.setMatricule(matricule);
        	vehiculeFacade.create(v);
        	
        	
        	if(trackerId != 0) {
        		VehiculetrackerPK pk = new VehiculetrackerPK();
            	pk.setDateDebut(new Date());
            	pk.setVehicule(v.getId());
            	pk.setTracker(trackerId);
            	
            	Tracker tracker = trackerFacade.find(trackerId);
            	
            	Vehiculetracker vehiculetracker = new Vehiculetracker();
            	vehiculetracker.setVehiculetrackerPK(pk);
            	vehiculetracker.setDateFin(null);
            	vehiculetracker.setVehicule1(v);
            	vehiculetracker.setTracker1(tracker);
            	vehiculetrackerFacade.create(vehiculetracker);
        	}
        	
        	response.sendRedirect("index.jsp");
        }
    }
	
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
