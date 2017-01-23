--Shinato's Ark (DM)
--Scripted by edo9300
function c511000590.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e1:SetCondition(c511000590.spcon)
	e1:SetTarget(c511000590.sptg)
	e1:SetOperation(c511000590.spop)
	c:RegisterEffect(e1)
	--lp
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51100567,13))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e2:SetCountLimit(1,511000590)
	e2:SetCondition(c511000590.lpcon)
	e2:SetCost(c511000590.lpcost)
	e2:SetTarget(c511000590.lptg)
	e2:SetOperation(c511000590.lpop)
	c:RegisterEffect(e2)
	--Spsummon Shinato
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCondition(c511000590.spcon2)
	e3:SetTarget(c511000590.sptg2)
	e3:SetOperation(c511000590.spop2)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCondition(c511000590.spcon3)
	e4:SetLabel(1)
	c:RegisterEffect(e4)
	if not c511000590.global_check then
		c511000590.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000590.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000590.dm=true
c511000590.dm_replace_original=true
function c511000590.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000590.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()==1-e:GetHandler():GetControler() and e:GetHandler():GetFlagEffect(300)>0
end
function c511000590.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000590.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c511000590.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tp=e:GetHandler():GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000590.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp)  end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,nil,tp,LOCATION_GRAVE)
end
function c511000590.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	local ct=Duel.GetMatchingGroupCount(c511000590.filter,c:GetControler(),0,LOCATION_MZONE,nil)
	if ct>5 then ct=5 end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ct>ft then ct=ft end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) and ct>2 then ct=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000590.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,ct,nil,e,tp)
	if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
	Duel.ChangeAttackTarget(g:Select(tp,1,1,nil):GetFirst())
	end
end
function c511000590.lpcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c511000590.lpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,TYPE_MONSTER) end
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,TYPE_MONSTER)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	e:SetLabel(ct)
end
function c511000590.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel()*500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,e:GetLabel()*500)
end
function c511000590.lpop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c511000590.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)==0
end
function c511000590.spfilter2(c,e,tp)
	return c:GetCode()==86327225 and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000590.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000590.spfilter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,nil,0,0)
end
function c511000590.spop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000590.spfilter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	if e:GetLabel()>0 then
	g:GetFirst():RegisterFlagEffect(300,0,0,1)
	end
end
function c511000590.spcon3(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end