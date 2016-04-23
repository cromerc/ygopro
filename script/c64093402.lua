--Mirage Ruler
function c64093402.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c64093402.condition)
	c:RegisterEffect(e1)
   	--Special Summon destroyed monsters
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27769400,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_BATTLE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c64093402.descon)
	e2:SetCost(c64093402.descost)
	e2:SetTarget(c64093402.sptg)
	e2:SetOperation(c64093402.spop)
	c:RegisterEffect(e2)
    if not c64093402.global_check then
	c64093402.global_check=true
	c64093402[0]=0
	c64093402[1]=0
	c64093402[2]=Group.CreateGroup()
	c64093402[2]:KeepAlive()
	c64093402[3]=0
	c64093402[4]=0
	local ge1=Effect.GlobalEffect()
	ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge1:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
	ge1:SetProperty(EFFECT_FLAG_REPEAT)
	ge1:SetCountLimit(1)
	ge1:SetOperation(c64093402.checkop)
	Duel.RegisterEffect(ge1,0)
	local ge2=Effect.CreateEffect(c)
	ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge2:SetCode(EVENT_PHASE_START+PHASE_MAIN2)
	ge2:SetProperty(EFFECT_FLAG_REPEAT)
	ge2:SetCountLimit(1)
	ge2:SetOperation(c64093402.clear)
	Duel.RegisterEffect(ge2,0)
	local ge3=Effect.GlobalEffect()
	ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge3:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
	ge3:SetOperation(c64093402.checkop1)
	Duel.RegisterEffect(ge3,0)
	local ge4=Effect.GlobalEffect()
	ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge4:SetCode(EVENT_DESTROYED)
	ge4:SetOperation(c64093402.checkop2)
	Duel.RegisterEffect(ge4,0)
	end
	end
function c64093402.condition(e,tp,eg,ep,ev,re,r,rp)
 return tp~=Duel.GetTurnPlayer()
end
function c64093402.descon(e,tp,eg,ep,ev,re,r,rp)
 return  c64093402[4]>0 and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 and Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c64093402.checkop(e,tp,eg,ep,ev,re,r,rp)
    c64093402[0]=c64093402[0]+Duel.GetLP(tp)
end
function c64093402.clear(e,tp,eg,ep,ev,re,r,rp)
    c64093402[0]=0
    c64093402[4]=0
end
function c64093402.checkop1(e,tp,eg,ep,ev,re,r,rp)
	c64093402[2]:Clear()
	c64093402[2]:Merge(Duel.GetFieldGroup(tp,LOCATION_MZONE,0))
	c64093402[3]=c64093402[2]:GetCount()
end
function c64093402.checkop2(e,tp,eg,ep,ev,re,r,rp)
    if  c64093402[3]==0 then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 then
     c64093402[4]=c64093402[4]+1
	end
end
function c64093402.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c64093402.filter(c,tid,e,tp)
	return c:GetTurnID()==tid  and c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c64093402.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c64093402.filter(chkc,e,tp,tid) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c64093402.filter,tp,LOCATION_GRAVE,0,1,nil,tid,e,tp) end
    	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c64093402.spop(e,tp,eg,ep,ev,re,r,rp)
   local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft1==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c64093402.filter,tp,LOCATION_GRAVE,0,ft1,ft1,nil,Duel.GetTurnCount(),e,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
	while tc do
	Duel.SpecialSummonStep(tc,0,tp,tp,false,false,tc:GetPreviousPosition())
	tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	Duel.SetLP(tp,c64093402[0],REASON_EFFECT)
	Duel.PayLPCost(tp,1000)
	end
end