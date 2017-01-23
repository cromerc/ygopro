--天穹覇龍ドラゴアセンション
function c511001780.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c511001780.atkval)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c511001780.desreptg)
	e2:SetOperation(c511001780.desrepop)
	c:RegisterEffect(e2)
end
function c511001780.atkval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*1000
end
function c511001780.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup() 
		and c:IsAbleToExtra() end
	return true
end
function c511001780.mgfilter(c,e,tp,sync)
	return c:IsControler(tp) and c:IsLocation(LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)
		and bit.band(c:GetReason(),0x80008)==0x80008 and c:GetReasonCard()==sync
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001780.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sumtype=c:GetSummonType()
	local mg=c:GetMaterial():Filter(c511001780.mgfilter,nil,e,tp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if Duel.SendtoDeck(c,nil,0,REASON_EFFECT+REASON_REPLACE)>0 
		and sumtype==SUMMON_TYPE_SYNCHRO and mg:GetCount()>0 
		and mg:GetCount()<=ft then
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end
