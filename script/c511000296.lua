--Number Ci1000: Numerronius Numerronia
function c511000296.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,13,5)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000296,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c511000296.spcon)
	e1:SetTarget(c511000296.sptg)
	e1:SetOperation(c511000296.spop)
	c:RegisterEffect(e1)
	--indes effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_ONLY_BE_ATTACKED)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_ONLY_ATTACK_MONSTER)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e5)
	--win
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DELAY)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetCountLimit(1)
	e6:SetOperation(c511000296.winop)
	c:RegisterEffect(e6)
	--negate attack
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(511000296,1))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_BE_BATTLE_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c511000296.nacon)
	e7:SetCost(c511000296.nacost)
	e7:SetOperation(c511000296.naop)
	c:RegisterEffect(e7)
	--number generic effect
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e8:SetValue(c511000296.indes)
	c:RegisterEffect(e8)
		if not c511000296.global_check then
		c511000296.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(c511000296.check)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000296.check(e,tp,eg,ep,ev,re,r,rp)
	if  Duel.GetTurnPlayer()==tp or Duel.GetFlagEffect(tp,511000296)~=0 then return end
	Duel.RegisterFlagEffect(tp,511000296,RESET_PHASE+PHASE_END,0,1)
end
c511000296.xyz_number=1000
function c511000296.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c511000296.cfilter(c,tp,code)
	return c:IsCode(code) and c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY)
end
function c511000296.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000296.cfilter,1,nil,tp,511000294)
end
function c511000296.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000296.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		c:SetMaterial(eg)
		Duel.Overlay(c,eg)
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		c:CompleteProcedure()
	end
end
function c511000296.chkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000296.winop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(tp,511000296)==0 then
			local WIN_REASON_NUMBER_Ci1000=0x52
			Duel.Win(tp,WIN_REASON_NUMBER_Ci1000)
	end
end
function c511000296.nacon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return bt:GetControler()==c:GetControler()
end
function c511000296.nacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000296.naop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.Recover(e:GetHandler():GetControler(),Duel.GetAttacker():GetAttack(),REASON_EFFECT)
	end
end
