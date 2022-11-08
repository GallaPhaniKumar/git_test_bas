const cds = require('@sap/cds')

class RiskService extends cds.ApplicationService{
    async init(){
        const db = await cds.connect.to('db')
        const { Risks } = db.entities('sap.ui.riskmanagement')

        this.after('READ','Risks', risksData => {
            const risks = Array.isArray(risksData) ? risksData : [risksData] ;
            risks.forEach(risk => {
                if(risk.impact >= 10000){
                    risk.criticality = 1;
                }else{
                    risk.criticality = 2;
                }
            })
        })

        await super.init()
    }
}

module.exports = { RiskService }