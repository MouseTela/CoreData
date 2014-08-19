//
//  ViewController.swift
//  CoreData
//
//  Created by Rafael Luiz on 25/07/14.
//  Copyright (c) 2014 Rafael Luiz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet var txtUsuario: UITextField
    
    @IBOutlet var txtSobrenome: UITextField
    
    @IBOutlet var txtIdade: UITextField
    
    @IBOutlet var txtSenha: UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Salvar(sender: AnyObject) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate);
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        
        var novoUsuario = NSEntityDescription.insertNewObjectForEntityForName("Usuarios", inManagedObjectContext: context) as NSManagedObject
        
        
        novoUsuario.setValue(txtUsuario.text, forKey: "usuario")
        novoUsuario.setValue(txtSobrenome.text, forKey: "sobrenome")
        novoUsuario.setValue(txtIdade.text, forKey: "idade")
        novoUsuario.setValue(txtSenha.text, forKey: "senha")
        
        context.save(nil);
        println("Usuario salvo");
        
    }
    
    
    @IBAction func Procurar(sender: AnyObject) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate);
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Usuarios")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "usuario = %@", txtUsuario.text)
        
        var resultado:NSArray = context.executeFetchRequest(request, error: nil)
        
        if(resultado.count > 0 ){
            
            var dados = resultado[0] as NSManagedObject
            txtUsuario.text = dados.valueForKey("usuario") as String
            txtSobrenome.text = dados.valueForKey("sobrenome") as String
            txtIdade.text = dados.valueForKey("idade") as String
            txtSenha.text = dados.valueForKey("senha") as String
            
        }else{
            
            println("Nao encontrou usuario");
            
        }
        
        
    }
    

}

