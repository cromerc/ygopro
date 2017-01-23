--Speedroid Vidroskull
function c511009385.initial_effect(c)
--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21250202,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_HAND)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c511009385.spcon)
	e3:SetTarget(c511009385.sptg)
	e3:SetOperation(c511009385.spop)
	c:RegisterEffect(e3)

	-- damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511009385.damcon)
	e2:SetOperation(c511009385.damop)
	c:RegisterEffect(e2)
	if not c511009385.global_check then
		c511009385.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c511009385.spcheckop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511009385.spcheckop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	while tc do
		if tc:GetSummonPlayer()==0 then p1=true else p2=true end
		tc=eg:GetNext()
	end
	if p1 then Duel.RegisterFlagEffect(0,511009385,RESET_PHASE+PHASE_END,0,1) end
	if p2 then Duel.RegisterFlagEffect(1,511009385,RESET_PHASE+PHASE_END,0,1) end
end

function c511009385.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetFlagEffect(1-tp,511009385)~=0 and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
end
function c511009385.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511009385.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,c511009385.penfilter,tp,LOCATION_EXTRA,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end



function c511009385.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep==tp and c:IsRelateToBattle() and eg:GetFirst()==c:GetBattleTarget()
end
function c511009385.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,ev,false)
end
