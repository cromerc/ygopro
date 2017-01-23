--Super Roboyarou (DM)
--Scripted by edo9300
function c511000571.initial_effect(c)
	--fusion material
	aux.AddFusionProcCode2(c,92421852,38916461,true,true)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1412158,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c511000571.atkcon)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
	--spsummon robolady
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1412158,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000571.spcon)
	e2:SetTarget(c511000571.sptg)
	e2:SetOperation(c511000571.spop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,511000571)
	e3:SetCondition(c511000571.spcon2)
	e3:SetTarget(c511000571.sptg2)
	e3:SetOperation(c511000571.spop2)
	c:RegisterEffect(e3)
	if not c511000571.global_check then
		c511000571.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000571.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000571.dm=true
c511000571.dm_revive_limit=true
function c511000571.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000571.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a==e:GetHandler() or d==e:GetHandler()) and d~=nil
end
function c511000571.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c511000571.spfilter(c,e,tp)
	return c:IsCode(75923050) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000571.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsAbleToExtra()
		and Duel.IsExistingMatchingCard(c511000571.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000571.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.SendtoDeck(c,nil,2,REASON_EFFECT)~=0 then
		local tc=Duel.GetFirstMatchingCard(c511000571.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
		if tc then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c511000571.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()==1-e:GetHandler():GetControler()
end	
function c511000571.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000571.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)>0 then
		Duel.ChangeAttackTarget(c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local g=Duel.GetMatchingGroup(Card.IsSSetable,tp,LOCATION_HAND,0,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(60082869,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
			local sg=g:Select(tp,1,1,nil)
			Duel.SSet(tp,sg:GetFirst())
		end
	end
end